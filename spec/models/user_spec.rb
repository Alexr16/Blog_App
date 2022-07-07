require 'rails_helper'

RSpec.describe User, type: :model do
    before :each do
        @user = User.new(name: 'John Doe', photo: 'http://example.com/photo.jpg', post_counter: 0, bio: 'Teacher from Mexico.')
        @user.save
    end

    it 'User is valid with valid attributes' do
        expect(@user).to be_valid
    end

    it 'name must not be blank' do
       @user.name = nil
       expect(@user).to be_invalid
    end

    it 'photo is valid' do
        @user.photo = 'http://example.com/photo.jpg'
        expect(@user).to be_valid
    end

    it 'bio is valid' do
        @user.bio = 'Teacher from Mexico.'
        expect(@user).to be_valid
    end

    it 'post_counter must not be blank' do
        @user.post_counter = nil
        expect(@user).to be_invalid
    end

    it 'post_counter must be an integer' do
        @user.post_counter = 'a'
        expect(@user).to be_invalid
    end

    it 'post_counter must be greater than or equal to 0' do
        @user.post_counter = -1
        expect(@user).to be_invalid
    end

    it 'last_three_posts returns the last three posts' do
        @post = Post.new(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
        @post.save
        @post = Post.new(author: @user, title: 'Hello2', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
        @post.save
        @post = Post.new(author: @user, title: 'Hello3', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
        @post.save
        @post = Post.new(author: @user, title: 'Hello4', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
        @post.save
        expect(@user.last_three_posts.count).to eq(3)
        expect(@user.last_three_posts.second.title).to eq('Hello3')
    end
end
