class Room < ApplicationRecord
  validates :name, uniqueness: true
  belongs_to :room_type

  scope :search, ->(name){where("name LIKE ?", "%#{name}%")}

  scope :rooms, ->(value){where("id not in (?)", value)}

  scope :rooms_in_booking, ->(value){where("id in (?)", value)}
end
