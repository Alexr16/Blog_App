class Api::V1::PostsController < ApplicationController
    def index
        # render json: User.all
        @user = User.find(params[:user_id])
        @posts = @user.posts.includes(:comments)
        render json: @posts
      end
    
    #   def show
    #     @post = Post.find(params[:id])
    #     @user = User.find(params[:user_id])
    #     @comment = Comment.new
    #     @comments = @post.comments.includes(:author)
    #   end
    
end