class User < ApplicationRecord
  belongs_to :state
  has_many :events
  has_many :rsvps, dependent: :destroy
  has_secure_password

  validates :first_name, :last_name, :email, :city, :state, presence: true
  validates :password, :password_confirmation, presence: true, if: :password_digest_changed?
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

end
