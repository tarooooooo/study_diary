class LearningDiary < ApplicationRecord
  belongs_to :study_category, optional: true
  belongs_to :user

  validates :body, presence: true, length: { in: 1..1000 }
  validates :study_day, presence: true
  validates :study_time, presence: true
  validates :user_id, presence: true
  validate :date_before_study_day

  def date_before_study_day
    return if study_day.blank?
    errors.add(:study_day, "に、未来の日程は設定できません。") if study_day > Date.today
  end
end
