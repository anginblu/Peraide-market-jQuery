class Skill < ActiveRecord::Base
  belongs_to :profile
  # validates :name, uniqueness: true
end
