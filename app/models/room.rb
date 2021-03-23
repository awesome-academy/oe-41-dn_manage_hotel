class Room < ApplicationRecord
  belongs_to :room_type
  has_many :bookings, dependent: :restrict_with_exception

  scope :sort_by_price, ->{order(price: :desc)}

  scope :rooms, (lambda do |rooms_booked|
    where("id not in (?)", rooms_booked).sort_by_price
  end)
end
