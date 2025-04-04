require 'rails_helper'

RSpec.describe AI::ContentGenerator, type: :service do
  let(:prompt) { create(:ai_prompt) }
  let(:static_page) { build(:static_page) }
  let(:service) { described_class.new(prompt, static_page) }
  let(:client) { instance_double(OmniAI::Anthropic::Client) }
  let(:successful_response) do
    OpenStruct.new(
      text: '{"content": "This is a test content"}'
    )
  end
  let(:failed_response) do
    OpenStruct.new(
      text: 'Invalid JSON response'
    )
  end

  before do
    allow(OmniAI::Anthropic::Client).to receive(:new).and_return(client)
  end

  describe '#initialize' do
    context 'with valid parameters' do
      it 'initialises successfully' do
        expect { service }.not_to raise_error
      end
    end

    context 'with invalid parameters' do
      it 'raises an error when new_record is blank' do
        expect { described_class.new(prompt, nil) }.to raise_error(ArgumentError, "New record is required")
      end

      it 'raises an error when prompt_additions is blank' do
        static_page.prompt_additions = nil
        expect { described_class.new(prompt, static_page) }.to raise_error(ArgumentError, "Prompt additions are required")
      end

      it 'raises an error when prompt is invalid' do
        invalid_prompt = build(:ai_prompt, content: nil)
        expect { described_class.new(invalid_prompt, static_page) }.to raise_error(ArgumentError, "Prompt must be valid")
      end
    end
  end

  describe '#call' do
    context 'with a successful API response' do
      before do
        allow(client).to receive(:chat).and_return(successful_response)
      end

      it 'generates content and saves it to the record' do
        service.call

        expect(static_page.content.to_plain_text).to include('This is a test content')
      end

      it 'calls the API with correct parameters' do
        expected_options = {
          model: OmniAI::Anthropic::Chat::Model::CLAUDE_3_7_SONNET_LATEST,
          temperature: 0.5
        }
        expect(client).to receive(:chat).with(service.send(:full_prompt), **expected_options)
        service.call
      end
    end

    context 'with an invalid API response' do
      before do
        allow(client).to receive(:chat).and_return(failed_response)
      end

      it 'raises a JSON::ParserError' do
        expect { service.call }.to raise_error(JSON::ParserError)
      end
    end
  end
end
