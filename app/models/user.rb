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
end
