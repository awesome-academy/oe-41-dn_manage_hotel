class User < ApplicationRecord
  enum role: {customer: 0, admin: 1, staff: 2}
  validates :name, presence: true
  validates :address, presence: true
  validates :id_card, presence: true
  validates :birthday, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX}
  before_save :downcase_email
  has_many :bookings, dependent: :restrict_with_exception
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
