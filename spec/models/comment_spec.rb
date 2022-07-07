require 'rails_helper'

RSpec.describe Comment, type: :model do
    before :each do
        @user = User.new(name: 'John Doe', photo: 'http://example.com/photo.jpg', post_counter: 0, bio: 'Teacher from Mexico.')
        @user.save
        @post = Post.new(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
        @post.save
        @comment = Comment.new(author: @user, post: @post, text: 'This is my first comment')
    end

    it 'Comment is valid with valid attributes' do
        expect(@comment).to be_valid
    end

    it 'text is valid' do
        @comment.text = 'This is my first post'
        expect(@comment).to be_valid
    end

    it 'author is valid' do
        @comment.author = @user
        expect(@comment).to be_valid
    end

    it 'post is valid' do
        @comment.post = @post
        expect(@comment).to be_valid
    end
end