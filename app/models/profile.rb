class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profiles_categories
  has_many :categories, through: :profiles_categories
  has_many :skills

  validates :title, presence: true
  validates :hourly, presence: true
  validate :available_from_cannot_be_in_the_past

  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :skills, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? }


  scope :cheapest, -> { order("hourly ASC LIMIT 1") }
  scope :currently_available, -> { where( 'available_from <= ?', Date.today ) }

  def available_from_cannot_be_in_the_past
    if available_from.present? && available_from < Date.today
      errors.add(:available_from, "can't be in the past")
    end
  end

  def self.in_category(category_name)
    @category = Category.find_by(name: category_name)
    self.categories.include?(@category)
  end

  def available_now?
    self.available_from <= Date.today
  end

  def cheapest?
    Profile.cheapest.where(id: self.id).any?
  end

  def best_option?
    self.available_now? && self.cheapest?
  end

end
