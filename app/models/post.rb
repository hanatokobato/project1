class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader

  belongs_to :user

  default_scope -> {order created_at: :desc}
  scope :feed, -> (user_id) {where user_id: user_id}

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
