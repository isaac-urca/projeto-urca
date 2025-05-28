class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_research_group
  before_action :set_membership, only: [:update, :destroy]

  def index
    @memberships = @research_group.memberships.includes(:user)
  end

  def update
    if @membership.update(membership_params)
      redirect_to research_group_memberships_path(@research_group), notice: 'Membro atualizado com sucesso.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    if @membership.destroy
      redirect_to research_group_memberships_path(@research_group), notice: 'Membro removido com sucesso.'
    else
      redirect_to research_group_memberships_path(@research_group), alert: 'Não foi possível remover o membro.'
    end
  end
  
  private
  
  def set_research_group
    @research_group = ResearchGroup.find(params[:research_group_id])
  end

  def set_membership
    @membership = @research_group.memberships.find(params[:id])
  end
  
  def membership_params
    params.require(:membership).permit(:role, :status)
  end

end
