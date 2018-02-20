class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def new
    if current_user
      redirect_to root_path, alert: "Already logged in."
    end
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to signin_path, notice: "Successfully created a new user account."
    else
      redirect_to new_user_path, alert: "Sign up failure.  Please retry!"
    end
  end

  def edit
    set_user
  end

  def update
    set_user
    @user.update(user_params)
    if @user.save
      redirect_to @user, notice: "Successfully updated your user account."
    else
      redirect_to edit_user_path(current_user), alert: "Please retry."
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :hourly, :available_from)
  end

end
