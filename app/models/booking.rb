class Booking < ApplicationRecord
  enum status: {pending: 0, payed: 1, cancel: 2, rejected: 3}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :check_start_date, :check_end_date
  validate :check_room_avalable, on: :create
  belongs_to :user
  belongs_to :customer
  belongs_to :room
  accepts_nested_attributes_for :customer
  delegate :name, to: :user, prefix: :user
  delegate :name, to: :customer, prefix: :customer
  delegate :name, :price, to: :room, prefix: :room

  scope :not_delete, ->{where(deleted: 0)}

  scope :sort_by_created, ->{order(created_at: :desc)}

  scope :rooms_booked, (lambda do |start_date, end_date|
    select(:room_id).pending.or(payed)
    .where("(?)<=end_date and(?)>=start_date", start_date, end_date)
  end)

  scope :room_booked_by_date, (lambda do |start_date, end_date, room_id|
    where(room_id: room_id).pending.or(payed)
    .where("start_date>= ? and end_date <= ?", start_date, end_date)
  end)

  scope :user_bookeds, (lambda do
    includes(:user, :customer, :room)
  end)

  scope :check_time_create_booked, (lambda do
    where(status: 0).where("created_at < ?", 24.hours.ago)
  end)

  def check_start_date
    return errors.add :start_date, I18n.t("sdate_not_blank") if
    start_date.blank?

    return errors.add :start_date, I18n.t("start_date_before_current_date") if
    start_date < Time.zone.today
  end

  def check_end_date
    return errors.add :end_date, I18n.t("end_date_not_blank") if
    end_date.blank?

    return errors.add :end_date, I18n.t("end_date_before_start_date") if
    end_date < start_date
  end

  def check_room_avalable
    bookings = Booking.not_delete
                      .room_booked_by_date(start_date, end_date, room_id)
    return if bookings.blank?

    errors.add :start_date, I18n.t("booking_date_exist")
    errors.add :end_date, I18n.t("booking_date_exist")
  end

  def update_delete_booked
    update_column :deleted, 1
  end
end
