class User < ApplicationRecord
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id

  validates_associated :comments
  validates_associated :likes
  validates_associated :posts

  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bio, presence: true
  validates :photo, presence: true
  validates :name, presence: true

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
