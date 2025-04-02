require 'rails_helper'

RSpec.describe Slugged do
  # Create a test model that includes the Slugged concern
  let(:test_model_class) do
    Class.new do
      attr_accessor :name, :title, :slug

      include Slugged

      def id
        123
      end
    end
  end

  let(:model) { test_model_class.new }

  describe '#to_param' do
    context 'when name_or_title is blank' do
      it 'returns the id as a string' do
        expect(model.to_param).to eq('123-')
      end
    end

    context 'when name_or_title is present' do
      it 'returns a parameterized string with id and name' do
        model.name = 'Test Model'
        expect(model.to_param).to eq('123-test-model')
      end

      it 'handles special characters in the name' do
        model.name = 'Test & Model!'
        expect(model.to_param).to eq('123-test-model')
      end
    end
  end

  describe '#name_or_title' do
    before(:each) do
      model.slug = nil
      model.name = nil
      model.title = nil
    end

    context 'when name is present' do
      it 'returns the name' do
        model.name = 'Test Name'
        expect(model.name_or_title).to eq('Test Name')
      end
    end

    context 'when name is not present but title is' do
      it 'returns the title' do
        model.title = 'Test Title'
        expect(model.name_or_title).to eq('Test Title')
      end
    end

    context 'when neither name nor title is present but slug is' do
      it 'returns the slug' do
        model.slug = 'test-slug'
        expect(model.name_or_title).to eq('test-slug')
      end
    end

    context 'when none of the attributes are present' do
      it 'returns blank string' do
        expect(model.name_or_title).to be_blank
      end
    end
  end
end
