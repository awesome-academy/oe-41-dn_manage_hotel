class Room < ApplicationRecord
  belongs_to :room_type
  has_many :bookings, dependent: :restrict_with_exception

  scope :not_in_ids, (lambda do |booked_rooms|
    where("id not in (?)", booked_rooms)
  end)
end
