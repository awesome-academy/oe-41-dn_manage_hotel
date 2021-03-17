class Room < ApplicationRecord
  belongs_to :room_type
  has_many :bookings, dependent: :restrict_with_exception

  scope :rooms_can_booking, (lambda do |booked_rooms, have_booking|
    where("id not in (?) or id not in (?)", booked_rooms, have_booking)
  end)
end
