require 'rails_helper'

RSpec.describe 'User index page', type: :system do
  describe 'index page' do
    before :each do
      @jorge = User.create(name: 'Jorge', photo: 'https://i.stack.imgur.com/YQu5k.png', bio: 'Hello world')
      visit root_path
    end
    it 'Shows the username of all other users' do
      expect(page).to have_content('Jorge')
    end
    it 'Shows the user photo of all other users' do
      expect(page).to have_css('img[src*="https://i.stack.imgur.com/YQu5k.png"]')
    end
    it 'Shows the user post counter of all other users' do
      expect(page).to have_content('Number of posts: 0')
    end
  end
end
