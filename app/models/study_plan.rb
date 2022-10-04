class StudyPlan < ApplicationRecord
  PERCENT_CONVERTION_NUMBER = 100
  belongs_to :user

  validates :title, length: { maximum: 500 }
  validates :weekly_target_time, presence: true

  def total_progress
    [(user.weekly_study_time / weekly_target_time.to_f * PERCENT_CONVERTION_NUMBER).floor, 100].min
  end

  def extra_time
    [(total_progress - PERCENT_CONVERTION_NUMBER), 0].max
  end
end
