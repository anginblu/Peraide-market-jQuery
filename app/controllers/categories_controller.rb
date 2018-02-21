class CategoriesController < ApplicationController
  def index
    @categories = Category.all

  end

  def show
    @category = Category.find(params[:id])
    @profiles = @category.profiles
    @user = best_user(@category)
  end


end
