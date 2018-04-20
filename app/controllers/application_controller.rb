class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def sign_in(user, scope: :user)
    session[:user_id] = @user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def valid_user?
    if @user = User.find_by(email: params[:user][:email])
      User.find_by(email: params[:user][:email]).valid_password?(params[:user][:password])
    else
      false
    end
  end

  def sign_out
    session.delete(:user_id)
  end

  def best_profile(category)
    category.profiles.currently_available.cheapest
  end


  helper_method :current_user, :logged_in?, :valid_user?, :best_profile


end
