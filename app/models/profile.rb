class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profiles_categories
  has_many :categories, through: :profiles_categories
  has_many :skills

  validates :title, presence: true
  validates :hourly, presence: true
  validate :available_from_cannot_be_in_the_past

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

  def build_new_category(category)
    unless self.categories.include?(category)
      self.profiles_categories.build(
        category_id: category.id,
      )
    end
  end

  def categories_attributes=(categories_attributes)
    categories_attributes.each do |key, value|

      ## if value["name"] is blank, don't do anything
      ## on this iteration
      unless value["name"] == ""

        ## if no ingredient id (value["id"]) is present, we know we're creating and not editing
        ## our first check can't just be by name because if we're in edit mode,
        ## the name might be different because we might have changed it
        ## so first we check if the id is present,
        ## if not we check if the ingredient was already created by another recipe
        ## if neither of those are true we make a brand new ingredient
        if Category.find_by(name: value["name"])
          self.build_new_category(Category.find_by(name: value["name"]))
        else
          @category = Category.new(name: value["name"])
          if @category.save
            self.build_new_category(@category)
          end
        end
      end
    end
  end

  def category_ids=(category_ids)
    category_ids.each do |id|
      unless id == ""
        @category = Category.find(id)
        self.build_new_category(@category)
      end
    end
  end

end
