class Booking < ApplicationRecord
  enum status: {pending: 0, payed: 1, cancel: 2}
  belongs_to :user
  belongs_to :customer
  belongs_to :room

  scope :not_delete, ->{where(deleted: 0)}

  scope :rooms_booked, (lambda do |start_date, end_date|
    select(:room_id).not_delete
    .where("(?)<=end_date and(?)>=start_date", start_date, end_date)
  end)
end
