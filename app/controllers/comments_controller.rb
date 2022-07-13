class CommentsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(comments_params)
    @comment.author_id = @user.id
    @comment.post_id = @post.id
    @comment.save
    redirect_to user_post_path(@user.id, @post.id)
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
