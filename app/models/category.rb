class Category < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :profiles_categories
  has_many :profiles, through: :profiles_categories
  has_many :skills, through: :profiles
  has_many :users, through: :profiles


  def self.with_profile
    array = []
    Category.all.each {|i| array << i if !i.profiles.empty? }
    array
  end

  def profile_size
    self.profiles.size
  end

end
