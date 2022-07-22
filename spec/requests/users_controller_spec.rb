require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before :each do
    @user = User.new(name: 'Juan', photo: 'Photo', bio: 'Hello world',
       email: 'jorge@icloud.com', password: '123456', password_confirmation: '123456', role: 'admin')
    @user.skip_confirmation!
    @user.save!
  end
  describe 'GET #index' do
    before { get users_path(@user) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'should render the correct text in the index template' do
      expect(response.body).to include('Juan')
    end
  end

  describe 'GET #show' do
    before { get user_path(@user) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end

    it 'should render the correct text in the show template' do
      expect(response.body).to include('Juan')
    end
  end
end
