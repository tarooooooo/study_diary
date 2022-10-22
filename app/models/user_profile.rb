class UserProfile < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: true
  validates :name, length: { maximum: 50 }

  mount_uploader :icon, UserProfileUploader
end
