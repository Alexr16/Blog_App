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

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    @post.update(comments_counter: @post.comments.count - 1)
    @post.save
    @comment.destroy
    redirect_to user_post_path(current_user, @comment.post_id)
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
