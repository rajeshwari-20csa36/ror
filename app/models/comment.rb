class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :user_comment_ratings, dependent: :destroy
  has_many :users, through: :user_comment_ratings
  def ratings_for_value(rating_value)
    user_comment_ratings.where(rating: rating_value)
  end

end
