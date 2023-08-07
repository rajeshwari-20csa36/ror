class Topic < ApplicationRecord
  self.per_page=2
  has_many :posts, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
