module PostsHelper
  def post_unread_indicator(post)
    "unread" if current_user && !post.read_by_users.include?(current_user)
  end
end
