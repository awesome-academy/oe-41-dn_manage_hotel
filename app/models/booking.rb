class Booking < ApplicationRecord
  enum status: {pending: 0, payed: 1, cancel: 2, rejected: 3}
  belongs_to :user
  belongs_to :customer
  belongs_to :room
  validate :check_date_booking?, on: :create
  validate :compare_current_date, on: :create
  validates_associated :customer
  accepts_nested_attributes_for :customer
  validate :check_room_can_booking, on: :create

  scope :rooms_booked, (lambda do |start_date, end_date|
    pending.or(payed)
    .where("(?)<=end_date and(?)>=start_date", start_date, end_date)
  end)

  scope :get_room_ids, ->{select(:room_id).not_delete}

  scope :not_delete, ->{where(deleted: 0)}

  scope :sort_by_id, ->{order(id: :desc)}

  scope :booking_of_room_at, (lambda do |start_date, end_date, room_id|
    pending.or(payed).where(room_id: room_id)
    .where("end_date <= (?) and start_date >= (?)", end_date, start_date)
  end)

  def check_date_booking?
    return errors.add :start_date, I18n.t("cannot_empty") if start_date.nil?

    return errors.add :end_date, I18n.t("cannot_empty") if end_date.nil?

    return errors.add :start_date, I18n.t("must_small") if start_date > end_date
  end

  def compare_current_date
    cur_day = Time.zone.today
    return errors.add :start_date, I18n.t("bigger") if start_date < cur_day

    return errors.add :end_date, I18n.t("bigger") if end_date < cur_day
  end

  def check_room_can_booking
    bookings = Booking.not_delete
                      .booking_of_room_at start_date, end_date, room_id
    return if bookings.blank?

    errors.add :start_date, I18n.t("date_exists")
    errors.add :end_date, I18n.t("date_exists")
  end
end
