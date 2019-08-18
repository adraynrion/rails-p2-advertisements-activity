class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.where(state: "published")
    @moderation_advertisements = Advertisement.where(state: "waiting")
  end

  def new
    redirect_not_connected_user
    @advertisement = Advertisement.new
  end

  def create
    redirect_not_connected_user
    @advertisement = Advertisement.new  title: params[:advertisement][:title],
      content: params[:advertisement][:content],
      price: params[:advertisement][:price],
      state: "waiting",
      user_id: @current_user.id
    if @advertisement.save
      flash[:success] = "L'annonce à bien été créer et est en attente de validation."
      redirect_to "/advertisements"
    else
      render "new"
    end
  end

  def show
    @advertisement = Advertisement.find(params[:id])

    if !@advertisement.published?
      if !@current_user
        flash[:info] = "Vous devez être connecté !"
        redirect_to "/users/login"
      elsif @current_user && !@current_user.admin?
        flash[:info] = "Vous devez être administrateur de ce site pour effectué cette commande."
        redirect_to request.referrer || "/advertisements"
      end
    end
  end

  def validate
    redirect_not_connected_user
    redirect_no_admin_user

    @advertisement = Advertisement.find(params[:id])
    if @advertisement.update state: "published"
      flash[:success] = "L'annonce à bien été publié !"
      redirect_to "/advertisements"
    else
      flash[:info] = "Une erreur est survenue."
      render "show"
    end
  end

  private

  def redirect_not_connected_user
    if !@current_user
      flash[:info] = "Vous devez être connecté !"
      redirect_to "/users/login"
    end
  end

  def redirect_no_admin_user
    if !@current_user.admin?
      flash[:info] = "Vous devez être administrateur de ce site pour effectué cette commande."
      redirect_to request.referrer || "/advertisements"
    end
  end
end
