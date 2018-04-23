class CategoriesController < ApplicationController
  def index
    @categories = Category.all

  end

  def show
    @category = Category.find(params[:id])
    @profiles = @category.profiles
    @skills = @category.skills
    @profiles = best_profile(@category)
  end

  def best
    @category = Category.find(params[:id])
    @profiles = best_profile(@category)
    # binding.pry
    # @profile = @profiles.first
    render layout:false
  end
end
