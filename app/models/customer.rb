class Customer < ApplicationRecord
  validates :name, presence: true
  validates :birthday, presence: true
  validates :address, presence: true
  validates :id_card, presence: true
  validate :check_birthday, on: :create

  def check_birthday
    cur_date = Time.zone.today
    return errors.add :birthday, I18n.t("birthday_error") if birthday > cur_date
  end
end
