class ResearchGroupsController < ApplicationController
  layout 'research_group', except: [:index, :new]
  before_action :set_research_group, only: [:show, :edit, :update, :destroy, :join, :leave]

  def index
    @research_groups = ResearchGroup.all
  end

  def show
    @posts = @research_group.posts.order(created_at: :desc)
    @membership = @research_group.memberships.find_by(user: current_user)
  end

  def new
    @research_group = ResearchGroup.new
  end

  def create
    @research_group = current_user.administered_research_groups.build(research_group_params)
    if @research_group.save
      redirect_to @research_group, notice: 'Grupo de pesquisa criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit;end

  def update
    if @research_group.update(research_group_params)
      redirect_to @research_group, notice: 'Grupo de pesquisa atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @research_group.destroy
    redirect_to research_groups_path, notice: 'Grupo de pesquisa excluído com sucesso.'
  end

  def join
    # if @research_group.public? || @research_group.memberships.exists?(user: current_user)
    #   @membership = @research_group.memberships.find_or_initialize_by(user: current_user)
    #   @membership.status = :active
    #   @membership.role = :member
    #   if @membership.save
    #     redirect_to @research_group, notice: 'Você entrou no grupo de pesquisa com sucesso.'
    #   else
    #     redirect_to @research_group, alert: 'Não foi possível entrar no grupo de pesquisa.'
    #   end
    # elsif @research_group.private?
    #   @membership = @research_group.memberships.find_or_initialize_by(user: current_user)
    #   @membership.status = :pending
    #   @membership.role = :member
    #   if @membership.save
    #     redirect_to @research_group, notice: 'Solicitação de adesão enviada. Aguarde a aprovação do administrador.'
    #   else
    #     redirect_to @research_group, alert: 'Este grupo é privado. Solicite acesso ao administrador.'
    #   end
    # end
    if @research_group.public_group?
      membership = @research_group.memberships.find_or_create_by(user: current_user)
      membership.update(status: :active, role: :member) # Garante que está ativo e é membro
      redirect_to @research_group, notice: 'Você entrou no grupo!'
    elsif @research_group.private_group?
      membership = @research_group.memberships.find_or_initialize_by(user: current_user)
      membership.update(status: :pending, role: :member) # Solicitação pendente
      redirect_to @research_group, notice: 'Sua solicitação para entrar no grupo foi enviada e está pendente de aprovação.'
    else # Secret group
      redirect_to research_groups_url, alert: 'Você não pode solicitar entrada em um grupo secreto.'
    end
  end

  def leave
    membership = @research_group.memberships.find_by(user: current_user)
    if membership
      membership.destroy
      redirect_to research_groups_path, notice: 'Você saiu do grupo de pesquisa.'
    else
      redirect_to @research_group, alert: 'Você não é membro deste grupo.'
    end
  end

  private
  
  def set_research_group
    @research_group = ResearchGroup.find(params[:id])
  end

  def research_group_params
    params.require(:research_group).permit(:name, :description, :visibility, :admin_id, :avatar)
  end
end
