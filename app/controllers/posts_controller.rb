class PostsController < ApplicationController
    
    before_action :find_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user, only: [:edit, :update, :destroy] 

    def index
        @posts = Post.all.order("created_at DESC")
    end

    def show
        @comments = Comment.where(post_id: @post).order("created_at ASC")
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "The post was created!"
            redirect_to @post    
        else
             render 'new'
        end 
    end

    def edit
    end

    def update
        if @post.update(post_params)
            flash[:success] = "Update successful"
            redirect_to @post
        else
            render 'edit'
        end
    end

    def destroy
        @post.destroy
        flash[:success] = "Post destroyed"
        redirect_to root_path
    end

private

    def post_params
        params.require(:post).permit(:content)
    end

    def find_post
        @post = Post.find(params[:id])
    end

    def correct_user
        @user = User.find(current_user.id)
        redirect_to(root_url) unless current_user.id == @post.user_id
    end
end
