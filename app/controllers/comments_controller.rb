class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comentário adicionado com sucesso.'
    else
      redirect_to post_path(@post), alert: 'Erro ao adicionar comentário.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      flash[:notice] = 'Comentário excluído com sucesso.'
    else
      flash[:alert] = 'Você não tem permissão para realizar esta ação.'
    end
    redirect_to post_path(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
