class CommentsController < ApplicationController
  def create
    redirect_not_connected_user
    @comment = Comment.new content: params[:comment][:content],
    advertisement_id: params[:id],
    user_id: @current_user.id
    if @comment.save
      flash[:success] = "Commentaire ajouté !"
      redirect_to "/advertisements/#{params[:id]}"
    else
      flash[:info] = "Une erreur est survenue."
      @advertisement = Advertisement.find(params[:id])
      @comments = Comment.where(advertisement_id: params[:id])
      render "advertisements/show"
    end
  end
end
