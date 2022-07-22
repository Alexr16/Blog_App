require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before :each do
    @user = User.new(name: 'Juan', photo: 'Photo', bio: 'Hello world', email: 'jorge@icloud.com', password: '123456', password_confirmation: '123456', role: 'admin')
    @user.skip_confirmation!
    @user.save!
    @post = @user.posts.create(title: 'Test', text: 'This is the Posts page.', author_id: @user.id)
  end

  describe 'GET #index' do
    before { get user_posts_path(@user, @post) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'should render the correct text in the show template' do
      expect(response.body).to include('This is the Posts page.')
    end
  end

  describe 'GET #show' do
    before do 
      get user_post_path(@user, @post)
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:show)
    end

    it 'should render the correct text in the show template' do
      expect(response.body).to include('This is the Posts page.')
    end
  end
end
