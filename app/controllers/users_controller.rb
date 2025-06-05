class UsersController < ApplicationController
  before_action :authenticate_user! # Usuários precisam estar logados para seguir
  before_action :set_user, only: [:show, :follow, :unfollow] # Adicione follow e unfollow

  def index
    @users = User.all
  end

  def follow
    unless current_user.following?(@user)
      current_user.following << @user
      flash[:notice] = "Você começou a seguir #{@user.email}."
    else
      flash[:alert] = "Você já está seguindo este usuário."
    end
    redirect_to @users
  end

  def unfollow
  end
  
  def show
    @user = User.find(params[:id])
    @followers_count = @user.followers.count
    @following_count = @user.following.count
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end
end
