# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetPageByPath do
  describe '#call' do
    context 'when the path is empty' do
      let(:service) { described_class.new('') }

      it 'returns a Success monad with an nil' do
        result = service.call
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.success).to be_nil
      end
    end

    context 'when no pages are found' do
      let(:service) { described_class.new('nonexistent/page') }

      it 'returns a Failure monad with an error message' do
        result = service.call
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to eq('Ни одной из страниц не обнаружено')
      end
    end

    context 'when the page is found' do
      let!(:root_page) { create(:page, name: 'root', parent_id: nil) }
      let!(:child_page) { create(:page, name: 'child', parent_id: root_page.id) }

      let(:service) { described_class.new('root/child') }

      it 'returns a Success monad with the found page' do
        result = service.call
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to eq(child_page)
      end
    end

    context 'when intermediate pages are missing in the path' do
      let!(:root_page) { create(:page, name: 'root', parent_id: nil) }
      let!(:child_page) { create(:page, name: 'child', parent_id: root_page.id) }

      let(:service) { described_class.new('root/nonexistent/child') }

      it 'returns a Failure monad with an error message' do
        result = service.call
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to eq('Страница не найдена')
      end
    end
  end
end
