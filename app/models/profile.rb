class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profiles_categories
  has_many :categories, through: :profiles_categories
  has_many :skills
  accepts_nested_attributes_for :categories, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :skills, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true

end
