class Post < ApplicationRecord
  self.per_page = 2

  # Validations
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true
  validates :topic, presence: true

  # Associations
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  has_many :ratings, dependent: :destroy

  # Active Storage attachment
  has_one_attached :image
  has_and_belongs_to_many :read_by_users, class_name: 'User', join_table: :posts_users_read_statuses



end
