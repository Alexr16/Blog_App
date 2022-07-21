class Api::V1::CommentsController < ApplicationController
    def index
        @post = Post.find(params[:post_id])
        @comments = @post.comments.includes(:author)
        render json: @comments
    end

    def create
      @user = current_user
      @post = Post.find(params[:post_id])
      @comment = @user.comments.new(comments_params)
      @comment.author_id = @user.id
      @comment.post_id = @post.id
      
      if @comment.save
          render json: { status: 201, message: 'Comment created successfully!', content: { comment: @comment } }
      else
          render json: @comment.errors, status: :bad_request, message: 'Operation failed'
      end
    end

    def comments_params
      params.require(:comment).permit(:text)
  end
end