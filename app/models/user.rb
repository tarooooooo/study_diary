class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true

  has_many :study_categories, dependent: :destroy
  has_many :learning_diaries, dependent: :destroy
  has_many :study_plans, dependent: :destroy

  def weekly_study_time
    learning_diaries.weekly_diaries(Date.current - Date.today.beginning_of_week).sum(:study_time)
  end

  def avg_daily_study_time
    weekly_study_time / (Date.today.beginning_of_week..Date.current).count
  end

  def current_study_plan
    study_plans&.last
  end

  def uncategorized_diaries_weekly_study_time_util_today
    learning_diaries.uncategorized_diary_until_today.sum(:study_time)
  end

  def uncategorized_diaries_study_time_util(number_of_day)
   learning_diaries.uncategorized_diary_until(number_of_day).sum(:study_time)
  end
end
