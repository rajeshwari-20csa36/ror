class RatingsController < ApplicationController
  before_action :set_post

  def create
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.new(rating_params)

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
    params.require(:rating).permit(:value)
  end
end