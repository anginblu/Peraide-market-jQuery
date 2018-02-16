class Skill < ActiveRecord::Base
  belongs_to :category
  belongs_to :profile
  validates :name, presence: true
end
