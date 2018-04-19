class CommentsController < ApplicationController
  before_action :set_profile, only: [:index, :show, :new, :create, :update]

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
    @comment = @profile.comments.new
    render layout: false
    # respond_to do |f|
    #   f.js {render 'new.js', layout: false}
    #   f.html {render 'new.html', layout: false}
    # end
  end

  def create
    @comment = @profile.comments.build(comment_params)
    if @comment.save
      render "comments/show", layout: false
    else
      redirect_to @profile, alert: "Unsuccessful."
    end
    # if !!current_user
    #   @comment.user_id = current_user
      # render json: @comment, status: 201
    # else
    #   redirect_to @profile, alert: "Please log in first."
    # end
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
