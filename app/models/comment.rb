class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true
  validates :text, presence: true

  after_save :update_comments

  private

  def update_comments
    post = self.post
    post.update(comments_counter: post.comments.count)
    comments.save
  end
end
