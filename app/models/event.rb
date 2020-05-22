class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invitations, class_name: 'Invitation', foreign_key: 'attended_event_id'
  has_many :attendees, class_name: 'User', through: :invitations, source: 'attendee'

  validates :date, presence: true

  scope :past, -> { where('date < ?', Time.now) }
  scope :upcoming, -> { where('date > ?', Time.now) }
end
