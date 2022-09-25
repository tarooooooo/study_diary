class LearningDiary < ApplicationRecord
  belongs_to :study_category, optional: true
  belongs_to :user

  validates :body, presence: true, length: { in: 1..1000 }
  validates :study_day, presence: true
  validates :study_time, presence: true
  validates :user_id, presence: true
end
