class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true

  has_many :study_categories, dependent: :destroy
end
