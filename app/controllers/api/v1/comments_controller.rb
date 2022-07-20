class Api::V1::CommentsController < ApplicationController
    def index
        @post = Post.find(params[:post_id])
        @comments = @post.comments.includes(:author)
        render json: @comments
    end
end