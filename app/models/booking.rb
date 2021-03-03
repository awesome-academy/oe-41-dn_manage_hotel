class Booking < ApplicationRecord
  enum status: {unpay: 0, pay: 1}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :check_end_date
  belongs_to :user
  belongs_to :customer
  belongs_to :room
  accepts_nested_attributes_for :customer
  scope :booked, (lambda do |start_date, end_date|
    select("room_id")
    .where("deleted=0")
    .where("(?)<=end_date and(?)>=start_date", start_date, end_date)
  end)

  scope :check_room_available?, (lambda do |room_id, sdate, edate|
    by_room(room_id, sdate, edate).or(by_end_date(sdate, edate))
  end)

  scope :by_room, (lambda do |room_id, sdate, edate|
    where(room_id: room_id, deleted: 0).by_start_date_end_date(sdate, edate)
  end)

  scope :by_start_date, (lambda do |sdate|
    where("? between start_date and end_date", sdate)
  end)

  scope :by_end_date, (lambda do |sdate, edate|
    where("? between start_date and end_date", edate).or(by_start_date(sdate))
  end)

  scope :by_start_date_end_date, (lambda do |sdate, edate|
    where("bookings.start_date >= ? and bookings.end_date <= ?", sdate, edate)
  end)

  def check_end_date
    return if end_date >= start_date

    errors.add :end_date, I18n.t("validation_end_date")
  end

  scope :room_in_booking, (lambda do
    select("room_id")
    .where("deleted=0")
  end)
end
