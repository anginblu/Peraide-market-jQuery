class SkillsController < ApplicationController

  before_action :set_category, only: [:index, :show]
  before_action :set_skill, only: [:show]

  def index
    @skills = @category.skills
    # binding.pry
  end

  def show
    @profile = @skill.profile
  end

  private
  def set_profile
    @profile= Profile.find(params[:profile_id])
  end

  def set_skill
    @skill= Skill.find(params[:id])
  end

end
