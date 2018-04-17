class CommentsController < ApplicationController

  before_action :set_profile, only: [:index, :show]
  before_action :set_user, only: [:create]

  def index
    @comments = @profile.comments
    # binding.pry
  end

  def show
    @comment = @profile.profile
  end

  def create

  end

  private
  def set_profile
    @profile= Profile.find(params[:profile_id])
  end

  def set_user
    @user= current_user
  end

end
