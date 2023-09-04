class UserCommentRatingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comment = Comment.find(params[:comment_id])
    @ratings = @comment.user_comment_ratings
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @rating = current_user.user_comment_ratings.build(comment: @comment, rating: params[:rating])

    if @rating.save
      redirect_to comment_user_comment_ratings_path(@comment), notice: 'Rating added successfully.'
    else
      render :index
    end
  end
end
