require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.new(name: 'John Doe', photo: 'http://example.com/photo.jpg', post_counter: 0,
                     bio: 'Teacher from Mexico.', email: 'jorge@icloud.com', password: '123456', role: 'admin')
    @user.skip_confirmation!
    @user.save
    @post = Post.new(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                     likes_counter: 0)
    @post.save
  end

  it 'Post is valid with valid attributes' do
    expect(@post).to be_valid
  end

  it 'title must not be blank' do
    @post.title = nil
    expect(@post).to be_invalid
  end

  it 'text is valid' do
    @post.text = 'This is my first post'
    expect(@post).to be_valid
  end

  it 'comments_counter must not be blank' do
    @post.comments_counter = nil
    expect(@post).to be_invalid
  end

  it 'comments_counter must be an integer' do
    @post.comments_counter = 'a'
    expect(@post).to be_invalid
  end

  it 'comment_counter must be greater than or equal to 0' do
    @post.comments_counter = -1
    expect(@post).to be_invalid
  end

  it 'last_five_comments returns the last five comments' do
    @comment = Comment.new(author: @user, post: @post, text: 'This is my first comment')
    @comment.save
    @comment = Comment.new(author: @user, post: @post, text: 'This is my second comment')
    @comment.save
    @comment = Comment.new(author: @user, post: @post, text: 'This is my third comment')
    @comment.save
    @comment = Comment.new(author: @user, post: @post, text: 'This is my fourth comment')
    @comment.save
    @comment = Comment.new(author: @user, post: @post, text: 'This is my fifth comment')
    @comment.save
    @comment = Comment.new(author: @user, post: @post, text: 'This is my six comment')
    @comment.save
    expect(@post.last_five_comments.count).to eq(5)
    expect(@post.last_five_comments.second.text).to eq('This is my fifth comment')
  end
end
