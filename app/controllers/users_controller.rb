class UsersController < ApplicationController
  def new
    redirect_connected_user
    @user = User.new
  end

  def create
    @user = User.new name: params[:user][:name], password: params[:user][:password]
    if @user.save
      flash[:success] = "Vous êtes maintenant enregistré !"
      redirect_to "/users/login"
    else
      render "new"
    end
  end

  def login
    redirect_connected_user
  end

  def check
    @current_user = User.find_by(name: params[:user][:name], password: params[:user][:password])
    if @current_user
      session[:user_id] = @current_user.id
      flash[:success] = "Vous êtes maintenant connecté !"
      redirect_to "/advertisements"
    else
      session[:user_id] = nil
      flash[:info] = "Echec de la connexion !"
      redirect_to "/users/login"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:info] = "Vous êtes maintenant déconnecté !"
    redirect_to "/users/login"
  end

  private

  def redirect_connected_user
    if @current_user
      flash[:info] = "Vous êtes déjà connecté !"
      redirect_to "/advertisements"
    end
  end
end
