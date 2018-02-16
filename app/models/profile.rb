class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profiles_categories
  has_many :categories, through: :profiles_categories
  has_many :skills
end
