class Customer < ApplicationRecord
  validates :name, presence: true
  validates :birthday, presence: true
  validates :address, presence: true
  validates :id_card, presence: true
end
