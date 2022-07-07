class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  def last_five_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    author.update(post_counter: author.posts.count)
  end
end
