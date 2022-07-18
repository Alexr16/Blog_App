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
  end
end
