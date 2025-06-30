# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    # On trouve l'article auquel le commentaire est associé
    @article = Article.find(params[:article_id])
    # On crée le commentaire en l'associant à l'article et à l'utilisateur courant
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article), notice: 'Commentaire ajouté avec succès.'
    else
      # S'il y a une erreur, on redirige avec une alerte.
      # On pourrait aussi rendre à nouveau la vue de l'article avec un message d'erreur.
      redirect_to article_path(@article), alert: "Le commentaire ne peut pas être vide."
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    # On vérifie que l'utilisateur est bien le propriétaire du commentaire
    if @comment.user == current_user
      @comment.destroy
      redirect_to article_path(@article), notice: 'Commentaire supprimé.'
    else
      redirect_to article_path(@article), alert: "Vous n'avez pas l'autorisation de supprimer ce commentaire."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end