class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :best, :destroy]

  def show
    @skills = @user.skills
    @profiles = @user.profiles
  end

  def new
    if current_user
      redirect_to root_path, alert: "Already logged in."
    end
    @title = "Sign up"
    @user = User.new
    @url = registered_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Successfully created a new user account. Welcome, #{@user.name}!"
    else
      @object = @user
      redirect_to register_path, alert: "Sign up failure.  Please retry!"
    end
  end

  def edit
    @url = @user
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to @user, notice: "Successfully updated your user account."
    else
      @object = @user
      redirect_to edit_user_path(current_user), alert: "Please retry."
    end
  end

  def destroy
    if current_user == @user
      @user.destroy
      redirect_to root_path, notice: "Successfully deleted an user account for #{@user.name}."
    else
      redirect_to signout_path, alert: "You don't have the authority to delete an user account for #{@user.name}!"
    end
  end


  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :hourly, :available_from).reject{|_, v| v.blank?}
  end

end
