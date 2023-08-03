# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before { get :new }

  it 'returns http success' do
    expect(response).to have_http_status(:success)
  end

  it 'assigns a new page to @page' do
    expect(assigns(:page)).to be_a_new(Page)
  end
end
