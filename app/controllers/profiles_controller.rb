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
      redirect_to @profile, notice: "Successfully created a new profile for you."
    else
      raise params.inspect
      redirect_to new_profile_path, alert: "Creation Failure! Please retry."
    end
  end

  def edit
    set_profile
    setup_profile @profile
  end

  def update
    set_profile
    @profile.title = params.require(:profile).require(:title).reject{|_, v| v.blank?}
    @profile.category_ids = params.require(:profile).permit(category_ids: []).reject{|_, v| v.blank?}
    @profile.skills_attributes = params.require(:profile).permit(skills_attributes: [:name, :_destroy]).reject{|_, v| v.blank?}
    @profile.save
    # binding.pry
    redirect_to @profile, notice: "Successfully update your profile."

  end


  def destroy
   set_profile
   @profile.destroy
   redirect_to root_path, notice: "Profile destroyed!"
 end

  private

  def profile_params
    params.require(:profile).permit(:title, category_ids: [], skills_attributes: [:name, :_destroy]).reject{|_, v| v.blank?}
  end

  def set_profile
    @profile = Profile.find_by(id: params[:id])
  end
  def setup_profile(profile)
    profile.skills ||= Skill.new
    3.times { profile.skills.build }
    profile
  end

end
