class SessionsController < ApplicationController


  def new
    @title = "Sign in"
    @user = User.new
  end


  def create
    if params[:provider]
      user = User.from_omniauth(env["omniauth.auth"])
      sign_in user
      redirect_to root_path
    else
      if !valid_user?
        redirect_to signin_path, alert: "Invalid email/password combination."
      else
        user = User.find_by(email: params[:user][:email])
        sign_in user
        redirect_to user, notice: "Welcome, #{user.name}."
      end
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
