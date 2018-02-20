class Category < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :profiles_categories
  has_many :profiles, through: :profiles_categories
end
