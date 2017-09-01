class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  default_scope -> {order created_at: :desc}
  scope :feed, (lambda do |user_id|
    following_ids = "SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id"
    where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: user_id)
  end)

  validates :user, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: Settings.post.max_length}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.post.picture_size.megabytes
      errors.add :picture, I18n.t("errors.messages.picture_size")
    end
  end
end
