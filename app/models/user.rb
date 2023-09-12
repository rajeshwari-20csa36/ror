class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_one_attached :avatar

  has_many :comments
  has_many :posts

  has_many :posts_users_read_statuses
  has_many :read_posts, through: :posts_users_read_statuses, source: :post, class_name: "Post"

  has_many :user_comment_ratings
  has_many :comment, through: :user_comment_ratings

  def mark_post_as_read(post)
    read_posts << post unless read_posts.include?(post)
  end
end
