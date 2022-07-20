class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comment = Comment.new
    @comments = @post.comments.includes(:author)
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

  def destroy
    @post = Post.find(params[:id])
    @user_owner = User.find(@post.author_id)
    @post.destroy
    @user_owner.decrement(:post_counter)
    @user_owner.save
    redirect_to user_posts_path(current_user)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
