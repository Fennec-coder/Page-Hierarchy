# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @pages_hierarchy' do
      pages_hierarchy = %w[page_1 p_2 p_3].map do |name|
        FactoryBot.create(:page, name: name)
      end

      get :index
      expect(assigns(:pages_hierarchy)).to eq(pages_hierarchy)
    end
  end
end
