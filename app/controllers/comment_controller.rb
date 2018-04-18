class CommentsController < ApplicationController

  before_action :set_profile, only: [:index, :show, :update]

  def index
    comments = @profile.comments
    render json: comments
    # binding.pry
  end

  def show
    @comment = @profile.comments.find(params[:id])
    render json: @comment
  end

  def new
    if !current_user
      redirect_to root_path, alert: "Please log in first."
    end
  end

  def create
    @comment = @profile.comments.new(comment_params)
    @comment.user_id = current_user
    if @comment.save
      render json: comment, status: 201
    else
      render
  end

  def update
    @comment = @profile.comments.find(params[:id])
    @comment.update(comment_params)
    render json: @comment
  end

  private
  def set_profile
    @profile= Profile.find(params[:profile_id])
  end

  def set_user
    @user= current_user
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
