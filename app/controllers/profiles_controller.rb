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
      setup_profile @profile
    else
      redirect_to root_path, alert: "Please log in first."
    end
  end

  def create
    # raise params.inspect
    @profile = Profile.new(user_id: current_user.id)
    @profile.update(profile_params)
    if @profile
      redirect_to root_path, notice: "Successfully created a new profile for you."
    else
      raise params.inspect
      redirect_to @profile, alert: "Creation Failure! Please retry."
    end
  end

  def edit
    @profile = Profile.find_by(id: params[:id])
    setup_profile @profile
  end

  def update
    @profile = Profile.find_by(id: params[:id])
    @profile.update(profile_params)
    redirect_to @profile, notice: "Successfully update your profile."

  end

  def destroy
   @profile.destroy
   redirect_to root_path, notice: "Profile destroyed!"
 end

  private

  def profile_params
    params.require(:profile).permit(category_ids: [], skills_attributes: [:name, :_destroy])
  end

  def setup_profile(profile)
    profile.skills ||= Skill.new
    3.times { profile.skills.build }
    profile
  end

end
