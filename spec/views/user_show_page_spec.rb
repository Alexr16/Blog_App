require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  describe 'index page' do
    before :each do
      @chris = User.new(name: 'Chris', photo: 'https://i.stack.imgur.com/YQu5k.png', bio: 'Hello world',
                        email: 'jorge@icloud.com', password: '123456', role: 'admin')
      @chris.skip_confirmation!
      @chris.save!
      @post = @chris.posts.create(title: 'Test', text: 'This is the Posts page.', author_id: @chris.id)
      @post1 = @chris.posts.create(title: 'Test1', text: 'This is the Posts page. Test1', author_id: @chris.id)
      @post2 = @chris.posts.create(title: 'Test2', text: 'This is the Posts page. Test2', author_id: @chris.id)
      visit user_path(@chris)
    end

    it 'Shows the user photo' do
      expect(page).to have_css('img[src*="https://i.stack.imgur.com/YQu5k.png"]')
    end

    it 'Shows the user name' do
      expect(page).to have_content('Chris')
    end

    it 'Shows the user post counter' do
      expect(page).to have_content('Number of posts: 3')
    end

    it 'Shows the user bio' do
      expect(page).to have_content('Hello world')
    end

    it 'Shows the user first three posts' do
      expect(page).to have_content('Test')
      expect(page).to have_content('Test1')
      expect(page).to have_content('Test2')
    end

    it 'Shows button to see all posts' do
      expect(page).to have_link('See all posts')
    end

    it 'Redirects to the posts show page when clicking on the users post' do
      click_link 'Post Test1'
      expect(page).to have_current_path("/users/#{@chris.id}/posts/#{@post1.id}?class=post_list_class")
    end

    it 'Redirects to the posts index page when clicking on the see all posts button' do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@chris)
    end
  end
end
