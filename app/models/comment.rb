class Comment < ActiveRecord::Base
  belongs_to :profile
  belongs_to :user
  validates :content, presence: true

  scope :most_recent, -> { order("created_at DESC LIMIT 1") }

  def self.by_user(user_id)
    @comment = Comment.find_by(user_id: user_id)
  end

end
