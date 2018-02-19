class UsersController < ApplicationController

    before_action :find_user

    def show
        @posts = Post.where(user_id: @user).order("created_at DESC")
    end

private

    def find_user
        @user = User.find(params[:id])
    end

end
