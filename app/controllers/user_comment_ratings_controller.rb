class UserCommentRatingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comment = Comment.find(params[:comment_id])
    @ratings = @comment.user_comment_ratings
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @rating = current_user.user_comment_ratings.find_by(comment_id: @comment.id)

    if @rating.present?
      @rating.update(rating: user_comment_ratings_params[:rating])
      redirect_to  comment_ratings_path(@comment), notice: 'Rating added successfully.'
    else
      @rating = current_user.user_comment_ratings.create!(comment_id: @comment.id, rating: user_comment_ratings_params[:rating])
      redirect_to  comment_ratings_path(@comment), notice: 'Rating added successfully.'
    end
  end


private


  def user_comment_ratings_params

    params.require(:user_comment_rating).permit(:rating, :user_id, :comment_id)
 end
end