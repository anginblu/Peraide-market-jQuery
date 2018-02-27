class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update, :destroy]

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
      2.times { @profile.categories.build; @profile.skills.build }
      Rails.logger.debug("New method executed")
    else
      redirect_to root_path, alert: "Please log in first."
    end
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    @object = @profile
    if @profile.save
      redirect_to @profile, notice: "Successfully created a new profile for you."
    else
      errors = @profile.errors.full_messages
      # flash[:alert] = "Creation Failure! Please retry."
      render 'profiles/new'
    end
  end

  def edit
    @profile.categories.build if @profile.categories.empty?
    @profile.skills.build if @profile.skills.empty?
    if @profile.user != current_user
      redirect_to @profile, alert: "You don't have the authority to edit this profile!"
    end
    @profile.skills.build
  end

  def update
    if @profile.update(profile_params)
      # binding.pry
      redirect_to @profile, notice: 'Your profile was successfully updated.'
    else
      # binding.pry
      errors = @profile.errors.full_messages
      # flash[:alert] = "Editing Failure! Please retry."
      render 'profiles/edit'
    end
  end


  def destroy
    if @profile.user == current_user
      @profile.delete
      redirect_to root_path, notice: "Profile has been destroyed!"
    else
      # binding.pry
      redirect_to @profile, alert: "You don't have the authority to delete this profile!"
    end
 end

  private

  def profile_params
    params.require(:profile).permit(:title, :hourly, :available_from, categories_attributes: [:id, :name, :_destroy], category_ids: [], skills_attributes: [:id, :name, :_destroy]).reject{|_, v| v.blank?}
  end

  def set_profile
    @profile = Profile.find_by(id: params[:id])
  end

end
