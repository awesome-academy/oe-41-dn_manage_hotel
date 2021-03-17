class User < ApplicationRecord
  enum role: {admin: 1, staff: 2, customer: 3}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  has_many :bookings, dependent: :restrict_with_exception
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :address, presence: true
  validates :id_card, presence: true
  validate :check_birthday
  validates :email, format: {with: VALID_EMAIL_REGEX}
  has_secure_password
  before_save :downcase_email

  private

  def check_birthday
    return errors.add :birthday, I18n.t("compare_current_date") if birthday.nil?

    errors.add :birthday, I18n.t("error_birthday") if birthday > Time.zone.today
  end

  def downcase_email
    email.downcase!
  end
end
