class User < ApplicationRecord
  DAYS = ["月", "火", "水", "木", "金", "土", "日"]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true

  has_many :study_categories, dependent: :destroy
  has_many :learning_diaries, dependent: :destroy
  has_many :study_plans, dependent: :destroy
  has_one :profile, class_name: 'UserProfile', dependent: :destroy

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

  def diary_column_chart_data
    uncategorized_diary_day_and_study_times = []
    DAYS.each_with_index do | day, number_of_day |
      uncategorized_diary_day_and_study_times.push(["#{day}", uncategorized_diaries_study_time_util(number_of_day) ])
    end
    column_chart_data = Array.new([{ name: "カテゴリ未指定", data: uncategorized_diary_day_and_study_times}])

    if study_categories
      study_categories.each do | study_category |
        categorize_diary_day_and_study_time = []
        DAYS.each_with_index do | day, number_of_day |
          categorize_diary_day_and_study_time.push(["#{day}", study_category.diary_study_time_util(number_of_day) ])
        end
        column_chart_data.push({ name: study_category.name, data: categorize_diary_day_and_study_time })
      end
      column_chart_data
    end
  end

  def diary_pie_chart_data
    category_and_study_time_hash = {"カテゴリ未指定" => uncategorized_diaries_weekly_study_time_util_today}
    if study_categories
      category_and_study_time_hash.merge(study_categories.joins_diary_until_today.group(:name).sum("learning_diaries.study_time")).sort_by { |_, v| -v }.to_h
    end
  end
end
