class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  private

  def redirect_not_connected_user
    if !@current_user
      flash[:info] = "Vous devez être connecté !"
      redirect_to "/users/login"
    end
  end
end
