class Post < ApplicationRecord
  self.per_page = 2
  validates :title, presence: true
  validates :content, presence: true
  validates :topic, presence: true
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :taggables , dependent: :destroy
  has_many :tags , through: :taggables
  has_many :ratings, dependent: :destroy

end
