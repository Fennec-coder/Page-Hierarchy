# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "PATCH #update" do
    let(:page) { create(:page) }

    context "with valid params" do
      it "updates the requested page" do
        patch :update, params: { name: page.name, page: { title: "New Title", id: page.id } }
        page.reload
        expect(page.title).to eq("New Title")
      end

      it "redirects to the updated page" do
        patch :update, params: { name: page.name, page: { title: "New Title", id: page.id } }
        expect(response).to redirect_to(page_path(page.name))
      end
    end

    context "with invalid params" do
      it "does not update the page" do
        patch :update, params: { name: page.name, page: { name: '', id: page.id } }
        page.reload
        expect(page.name).not_to eq('')
      end

      it "re-renders the edit template" do
        patch :update, params: { name: page.name, page: { name: '', id: page.id } }
        expect(response).to render_template(:edit)
      end
    end
  end
end
