class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end

  # def comment
  #   @post = Post.find(params[:id])
  #   @comment = Comments.new(post: @post.id, author: current_user.id,  text: params[:text])
  #   @comment.save
  #   redirect_to user_post_path(current_user.id, Post.find(params[:post_id]))
  # end

  def post_params
    params.require(:post).permit(:title, :text)
  end

end
