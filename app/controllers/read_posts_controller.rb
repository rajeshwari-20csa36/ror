class ReadPostsController < ApplicationController
  before_action :authenticate_user!

  def mark_post_as_read
    post = Post.find(params[:post_id])
    current_user.mark_post_as_read(post)
    redirect_to post, notice: "Post marked as read."
  end
end
