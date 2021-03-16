class Room < ApplicationRecord
  belongs_to :room_type

  scope :rooms, ->{order(price: :desc)}
end
