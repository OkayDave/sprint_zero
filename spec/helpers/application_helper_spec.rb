require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#head_page_title' do
    context 'when title is not set' do
      it 'returns the default title' do
        expect(helper.head_page_title).to eq('Sprint Zero')
      end
    end

    context 'when title is set' do
      before do
        allow(helper).to receive(:content_for).with(:title).and_return('Test Page')
      end

      it 'returns the set title with the app name' do
        expect(helper.head_page_title).to eq('Test Page || Sprint Zero')
      end
    end
  end
end
