class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_posts_counter

  def update_posts_counter
    author.update(post_counter: author.posts.count)
  end

  private

  def last_five_comments
    comments.order(created_at: :desc).limit(5)
  end
end
