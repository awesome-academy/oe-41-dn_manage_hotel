class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  belongs_to :room

  scope :rooms_booked, (lambda do |start_date, end_date|
    get_room_ids
    .where("(?)<=end_date and(?)>=start_date", start_date, end_date)
  end)

  scope :get_room_ids, ->{select(:room_id).not_delete}

  scope :not_delete, ->{where(deleted: 0)}
end
