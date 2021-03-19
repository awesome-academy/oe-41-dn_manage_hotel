class Room < ApplicationRecord
  belongs_to :room_type

  scope :sort_by_price, ->{order(price: :desc)}

  scope :rooms, (lambda do |rooms_booked|
    where("id not in (?)", rooms_booked).sort_by_price
  end)
end
