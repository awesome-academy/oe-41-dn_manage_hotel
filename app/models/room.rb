class Room < ApplicationRecord
  belongs_to :room_type
  has_many :bookings, dependent: :restrict_with_exception
  delegate :name, to: :room_type, prefix: :room_type

  scope :sort_by_price, ->{order(price: :desc)}

  scope :not_delete, ->{where(deleted: 0)}

  scope :rooms, (lambda do |rooms_booked|
    where("id not in (?)", rooms_booked).sort_by_price
  end)
end
