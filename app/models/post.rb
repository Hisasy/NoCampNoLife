class Post < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ImageUploader

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many :comments, dependent: :destroy

  validates :main_title, presence: true, length: { maximum: 30 }
  validates :date, presence: true
  validates :location, presence: true, length: { maximum: 30 }
  validates :images, presence: true, length: { maximum:  10 }


  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
