class StudyCategory < ApplicationRecord
  belongs_to :user
  has_many :learning_diaries, dependent: :restrict_with_error

  validates :name, uniqueness: { scope: :user_id }, presence: true
  validates :user_id, presence: true

  def daily_learning_diary_study_time(date:)
    learning_diaries.where(study_day: date).sum(:study_time)
  end
end
