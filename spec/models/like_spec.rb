require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.new(name: 'John Doe', photo: 'http://example.com/photo.jpg', post_counter: 0,
                     bio: 'Teacher from Mexico.')
    @user.save
    @post = Post.new(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                     likes_counter: 0)
    @post.save
    @like = Like.new(author: @user, post: @post)
  end

  it 'Like is valid with valid attributes' do
    expect(@like).to be_valid
  end

  it 'author is valid' do
    @like.author = @user
    expect(@like).to be_valid
  end

  it 'post is valid' do
    @like.post = @post
    expect(@like).to be_valid
  end
end
