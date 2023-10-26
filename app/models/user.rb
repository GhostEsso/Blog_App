class User < ApplicationRecord
  has_many :post, foreign_key: 'author_id'
  has_many :comment
  has_many :like

  validates :name, presence: true
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def three_recent_posts
    Post.where(author: self).order(created_at: :desc).first(3)
  end
end
