class CommentsController < ApplicationController

    before_action :find_post
    before_action :find_comment, only: [:destroy, :edit, :update]
    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update, :destroy] 

    def create
        @comment = @post.comments.create(params[:comment].permit(:content))
        @comment.user_id = current_user.id
        @comment.save

        if @comment.save
            redirect_to post_path(@post)
        else
            render 'new'
        end
    end

    def destroy
        @comment.destroy
        redirect_to post_path(@post)
    end

    def edit
    end

    def update
        if @comment.update(params[:comment].permit(:content))
            redirect_to post_path(@post)
        else
            render 'edit'
        end
    end

private

    def find_post
        @post = Post.find(params[:post_id])
    end

    def find_comment
        @comment = @post.comments.find(params[:id])
    end

    def correct_user
        @user = User.find(current_user.id)
        redirect_to(post_path(@post)) unless current_user.id == @comment.user_id
    end

end
