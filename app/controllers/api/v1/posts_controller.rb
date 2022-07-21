class Api::V1::PostsController < ApplicationController
    def index
        # render json: User.all
        @user = User.find(params[:user_id])
        @posts = @user.posts.includes(:comments)
        render json: @posts, status: :ok
      end
end