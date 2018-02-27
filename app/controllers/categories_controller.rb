class CategoriesController < ApplicationController
  def index
    @categories = Category.all

  end

  def show
    @category = Category.find(params[:id])
    @profiles = @category.profiles
    @skills = @category.skills
    @profile = best_profile(@category)
  end



end
