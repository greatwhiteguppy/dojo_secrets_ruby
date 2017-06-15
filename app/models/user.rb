class User < ApplicationRecord
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  before_save :normalize_email

  validates :name, presence: true
  validates :email, presence: true,  format: {with: EMAIL_REGEX}, uniqueness: true, case_sensitive: false
  def normalize_email
    self.email.downcase!
  end
end
