class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :comments
  has_many :posts

  has_many :posts_users_read_statuses
  has_many :read_posts, through: :posts_users_read_statuses, source: :post, class_name: "Post"


  def mark_post_as_read(post)
    read_posts << post unless read_posts.include?(post)
  end

end
