class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true

  after_save :update_likes

  def update_likes
    post = self.post
    post.update(likes_counter: post.likes.count)
  end
end
