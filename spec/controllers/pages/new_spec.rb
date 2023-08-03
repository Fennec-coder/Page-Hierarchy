# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  it "returns http success" do
    get :new
    expect(response).to have_http_status(:success)
  end

  it "assigns a new page to @page" do
    get :new
    expect(assigns(:page)).to be_a_new(Page)
  end
end
