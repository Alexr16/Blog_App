class LikesController < ApplicationController
    def create
        @user = current_user
        @post = Post.find(params[:post_id])
        if liked?
            redirect_to user_posts_path(@user.id)
        else
            @like = @user.likes.new
            @like.author_id = @user.id
            @like.post_id = @post.id
            @like.save
            redirect_to user_posts_path(@user.id)
        end
    end

    def liked?
        Like.where(author_id: @user.id, post_id: @post.id).exists?
    end
end