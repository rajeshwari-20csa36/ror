class UserCommentRatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment

  def index
    @ratings = @comment.user_comment_ratings
    respond_to do |format|
      format.html { head :no_content } # Return 204 No Content for HTML requests
      format.json { render json: @ratings } # Render JSON for JSON requests
    end
  end

  def create
    @rating = current_user.user_comment_ratings.find_or_initialize_by(comment: @comment)
    @rating.rating = user_comment_ratings_params[:rating]

    if @rating.save
      redirect_to comment_ratings_path(@comment), notice: 'Rating added successfully.'
    else
      redirect_to comment_ratings_path(@comment), alert: 'Failed to add rating.'
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

  def user_comment_ratings_params
    params.require(:user_comment_rating).permit(:rating)
  end
end
