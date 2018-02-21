class RegisterController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to signin_path, notice: "Successfully created a new user account."
    else
      redirect_to new_user_path, alert: "Sign up failure.  Please retry!"
    end
  end

end
