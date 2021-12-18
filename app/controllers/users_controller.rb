class UsersController < ApplicationController

  before_action :set_user, only:[:likes]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end


  def quit
    @uuser = current_user
  end

  def out
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理が完了いたしました"
    redirect_to "/"
  end
  
  def following
    # @userがフォローしているユーザー
    @user = User.find(params[:id])
    @users = @user.following
    render "show_follow"
  end

  def followers
    # @userをフォローしているユーザー
    @user = User.find(params[:id])
    @users = @user.followers
    render "show_follower"
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :email, :password, :image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
