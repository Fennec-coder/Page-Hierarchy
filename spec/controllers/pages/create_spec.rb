# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      it "creates a new page" do
        expect {
          post :create, params: { page: attributes_for(:page) }
        }.to change(Page, :count).by(1)
      end

      it "redirects to the created page" do
        post :create, params: { page: attributes_for(:page) }
        expect(response).to redirect_to(page_path(assigns(:page).name))
      end
    end

    context "with invalid params" do
      it "does not create a new page" do
        expect {
          post :create, params: { page: { name: '' } }
        }.not_to change(Page, :count)
      end

      it "re-renders the new template" do
        post :create, params: { page: { name: '' } }
        expect(response).to render_template(:new)
      end
    end
  end
end
