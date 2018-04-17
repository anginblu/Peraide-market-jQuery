class User < ActiveRecord::Base
  require 'securerandom'
  require 'date'

  has_many :profiles

  has_many :comments

  has_many :skills, through: :profiles

  has_many :profiles_categories, through: :profiles
  has_many :categories, through: :profiles_categories

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # # validates :available_from, not_in_past: true, if: 'available_from.present?'
  #
  #
  # scope :cheapest, -> { order("users.hourly ASC LIMIT 1") }
  # scope :currently_available, -> { where( 'available_from <= ?', Date.today ) }
  # scope :in_category, -> { where( 'available_from <= ?', Date.today ) }

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


  # def available_from_cannot_be_in_the_past
  #   if available_from.present? && available_from < Date.today
  #     errors.add(:available_from, "can't be in the past")
  #   end
  # end


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
