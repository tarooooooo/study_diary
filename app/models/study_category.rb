class StudyCategory < ApplicationRecord
  belongs_to :user
  has_many :learning_diaries, dependent: :restrict_with_error

  validates :name, uniqueness: { scope: :user_id }, presence: true
  validates :user_id, presence: true

  scope :joins_diary_until_today, -> { joins(:learning_diaries).where(learning_diaries: { study_day: Date.today.beginning_of_week..Date.current }) }


  def daily_learning_diary_study_time(date:)
    learning_diaries.where(study_day: date).sum(:study_time)
  end

  def diary_study_time_util(number_of_day)
  learning_diaries.diary_util(number_of_day).sum(:study_time)
  end
end
