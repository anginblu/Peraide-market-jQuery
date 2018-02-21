class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
      redirect_to root_path, notice: "Successfully created a new user account."
    else
      redirect_to register_path, alert: "Sign up failure.  Please retry!"
    end
  end

  def edit
    set_user
    @url = @user
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

  def best
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
    render 'show'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "Successfully deleted an user account for #{@user.name}."
  end


  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :hourly, :available_from).reject{|_, v| v.blank?}
  end

end
