class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy]

  def show
  end


  def edit
  end

  def update
    if @user_profile.update(user_profile_params)
      redirect_to @user_profile, notice: 'Perfil atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_profile.destroy
    redirect_to root_path, notice: 'Perfil excluído com sucesso.'
  end

  private

  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  end

  def user_profile_params
    params.require(:user_profile).permit(:name, :bio)
  end
end
