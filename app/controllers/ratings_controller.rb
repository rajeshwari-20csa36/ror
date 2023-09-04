class RatingsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.new(rating_params)
    @user = current_user
    if @rating.save
      redirect_to topic_post_path(@post.topic_id, @post), notice: 'Rating was successfully created.'
    else
      redirect_to topic_post_path(@post.topic_id, @post), alert: "Rating could not be saved."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def rating_params
    params.require(:rating).permit(:value).merge(:user_id)
  end
end
