class User < ActiveRecord::Base
  require 'securerandom'
  require 'date'

  has_many :profiles

  has_many :skills, through: :profiles

  has_many :profiles_categories, through: :profiles
  has_many :categories, through: :profiles_categories

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :cheapest, -> { order("users.hourly ASC LIMIT 1") }
  scope :currently_available, -> { where( 'available_from <= ?', Date.today ) }
  scope :in_category, -> { where( 'available_from <= ?', Date.today ) }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.urlsafe_base64
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def available_now?
    self.available_from <= Date.today
  end

  def in_category(category)
    self.profile.categories.include?(category)
  end


  #
  # def self.cheapest
  #   where(hourly: true).order('hourly ASC').first
  # end
  #
  # def self.available
  #   where( available_from <= Date.today )
  # end
  #
  # def self.in_category(category)
  #   where( category: category )
  # end

end
