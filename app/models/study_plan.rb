class StudyPlan < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 500 }
  validates :weekly_target_time, presence: true
end
