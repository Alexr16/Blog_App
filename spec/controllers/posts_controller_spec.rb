require 'rails_helper'

RSpec.describe 'Posts', type: :request do
describe 'GET #index' do
    before(:each) { get user_posts_path(2) }
    it "is a success" do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'should render the correct text in the index template' do
        expect(response.body).to include('This is the Posts index page.')
    end
end

end