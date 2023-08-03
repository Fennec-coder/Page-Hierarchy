# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'DELETE #destroy' do
    let!(:page) { create(:page) }

    it 'destroys the requested page' do
      expect do
        delete :destroy, params: { name: page.name, id: page.id }
      end.to change(Page, :count).by(-1)
    end

    it 'redirects to the root page' do
      delete :destroy, params: { name: page.name, id: page.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
