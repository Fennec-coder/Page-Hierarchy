# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #show" do
    let(:page) { create(:page) }

    it "returns http success" do
      get :show, params: { name: page.name }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested page to @page" do
      get :show, params: { name: page.name }
      expect(assigns(:page)).to eq(page)
    end
  end
end
