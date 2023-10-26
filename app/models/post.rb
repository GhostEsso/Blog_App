class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_keys: 'author_id'
  has_many :posts, foreign_keys: 'author_id'
  has_many :comments
  has_many :likes

  validates :author_id, presence: true
  validates :title, presence: true
  validates :text, presence: true

  after_save :update_post_counter

  private

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_post_counter
    update(posts_counter: posts.count)
  end
end
