# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesHelper, type: :helper do
  describe '#render_page_hierarchy' do
    let(:pages_data) do
      [
        { 'id' => 1, 'parent_id' => nil, 'name' => 'страница' },
        { 'id' => 2, 'parent_id' => 1, 'name' => 'подстраница' },
        { 'id' => 3, 'parent_id' => 2, 'name' => 'подстраница' },
        { 'id' => 4, 'parent_id' => 3, 'name' => 'подподстраница' }
      ]
    end

    it 'renders the hierarchical structure as nested lists' do
      result = helper.render_page_hierarchy(pages_data)
      expected_output = '<ul><li><a href="/страница">страница</a></li><ul><li><a href="/страница/подстраница">подстраница</a></li><ul><li><a href="/страница/подстраница/подстраница">подстраница</a></li><ul><li><a href="/страница/подстраница/подстраница/подподстраница">подподстраница</a></li></ul></ul></ul></ul>'
      expect(result).to eq(expected_output)
    end
  end

  describe '#format_page_text' do
    it 'formats the text with bold, italic, and links' do
      text = '*[Bold]* \\\\[Italic]\\\\ ((page1 Link1)) ((page2 Link2))'
      result = helper.format_page_text(text)
      expected_output = '<b>Bold</b> <i>Italic</i> <a href="/pages/page1">Link1</a> <a href="/pages/page2">Link2</a>'
      expect(result).to eq(expected_output)
    end
  end
end
