# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #edit' do
    let(:page) { create(:page) }

    before { get :edit, params: { name: page.name } }

    it 'returns http success and assigns the requested page to @page' do
      expect(assigns(:page)).to eq(page)
      expect(response).to have_http_status(:success)
    end
  end
end
