module AI
  class ContentGenerator < ApplicationService
    BASE_PROMPT = <<~PROMPT
      Hello,

      Can't wait to work with you on this, it's an absolute belter!

      Could you help with creating some content please? Here's the gist of what I'm looking for:

      <<<CONTENT>>>

      <<<PROMPT_ADDITIONS>>>

      ---

      Please respond with the content in the following JSON format. Please do not include any other text in your response:

      <<<RESPONSE_FORMAT>>>

      ---

      Thank you!
    PROMPT

    attr_accessor :prompt, :new_record, :options, :completion

    def initialize(prompt, new_record)
      @prompt = prompt
      @new_record = new_record

      raise ArgumentError, "New record is required" if @new_record.blank?
      raise ArgumentError, "Prompt additions are required" if @new_record.prompt_additions.blank?
      raise ArgumentError, "Prompt must be valid" unless @prompt.valid?
    end

    def call
      parse_additional_options
      send_request
      save_record
    end

    private

    def to_json
      raise RuntimeError, "Completion is required" if @completion.blank?

      matches = @completion.text.match /({.+})/im

      raise JSON::ParserError, "No valid JSON found in response" if matches.blank?

      begin
        JSON.parse(matches[0])
      rescue JSON::ParserError
        JSON.parse(matches[1])
      end
    end

    def save_record
      @new_record.content = to_json["content"]
      @new_record.save!
    end

    def full_prompt
      BASE_PROMPT
        .gsub("<<<CONTENT>>>", @prompt.content)
        .gsub("<<<PROMPT_ADDITIONS>>>", @new_record.prompt_additions || "")
        .gsub("<<<RESPONSE_FORMAT>>>", @prompt.response_format)
    end

    def client
      @client ||= OmniAI::Anthropic::Client.new
    end

    def parse_additional_options
      @options ||= {
        model: OmniAI::Anthropic::Chat::Model::CLAUDE_3_7_SONNET_LATEST,
        temperature: 0.5
      }

      @prompt.additional_options = JSON.parse(@prompt.additional_options) if @prompt.additional_options.is_a?(String)
      @options.merge!(@prompt.additional_options.to_hash)
      @options.transform_keys!(&:to_sym)
    end

    def send_request
      @completion = client.chat full_prompt, **@options
    end
  end
end
