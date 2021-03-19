class Comment < ApplicationRecord
  belongs_to :comment, optional: true
  belongs_to :blog
  belongs_to :user

  has_many :comments, dependent: :destroy

  validate :only_author_reply

  def only_author_reply
  if comment_id.present?
  errors.add(:base, "You are not authorized to do this action.") if user_id != blog.user_id
  end
  end
end