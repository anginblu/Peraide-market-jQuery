class ProfilesController < ApplicationController

  def index
    @profiles = Profile.all
  end

  def user_index
    @profiles = current_user.profiles
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    if current_user
      @profile = Profile.new(user_id: current_user.id)
    else
      redirect_to root_path, alert: "Please log in first."
    end
  end

  def create
    # raise params.inspect
    @profile = User.new(profile_params)
    if @profile.save
      redirect_to root_path, notice: "Successfully created a new profile for you."
    else
      redirect_to new_user_profile_path, alert: "Creation Failure! Please retry."
    end
  end

  def destroy
   @profile.destroy
   redirect_to root_path, notice: "Profile destroyed!"
 end

  private

  def profile_params
    params.require(:profile).permit(:category_ids, skills_attributes: [])
  end

end
