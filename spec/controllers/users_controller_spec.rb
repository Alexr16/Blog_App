require 'rails_helper'

RSpec.describe 'Users', type: :request do
describe 'GET #index' do
    before(:each) { get users_path }  # get(:index)
    it "is a success" do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'should render the correct text in the index template' do
        expect(response.body).to include('This is the Users index page.')
    end
end
end
