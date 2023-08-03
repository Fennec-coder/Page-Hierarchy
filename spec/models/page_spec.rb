# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Page, type: :model do
  describe 'associations' do
    it { should belong_to(:parent).class_name('Page').optional }
    it { should have_many(:children).class_name('Page').with_foreign_key('parent_id').dependent(:destroy) }
  end

  describe 'validations' do
    subject { described_class.new(name: 'test_page') }

    it { should validate_presence_of(:name) }
    it { should allow_value('test_page').for(:name) }
    it { should_not allow_value('test_page!').for(:name) }

    context 'when name is unique among children' do
      let(:parent_page) { Page.create(name: 'parent_page') }

      it 'is valid' do
        child_page = parent_page.children.build(name: 'child_page')
        expect(child_page).to be_valid
      end
    end

    context 'when name is not unique among children' do
      let(:parent_page) { Page.create(name: 'parent_page') }

      it 'is invalid' do
        parent_page.children.create(name: 'child_page')
        duplicate_child_page = parent_page.children.build(name: 'child_page')
        expect(duplicate_child_page).not_to be_valid
      end
    end
  end
end
