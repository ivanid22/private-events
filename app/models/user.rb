class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  has_many :invitations, class_name: 'Invitation', foreign_key: 'attendee_id'
  has_many :accepted_invitations, -> {where(accepted: true)}, class_name: 'Invitation', foreign_key: 'attendee_id'
  has_many :unaccepted_invitations, -> {where(accepted: false)}, class_name: 'Invitation', foreign_key: 'attendee_id'

  has_many :attended_events, through: :accepted_invitations, source: 'attended_event'

 # has_many :accepted_events, class_name: 'Event', through: :accepted_invitations, source: 'attended_event'

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def upcoming_events
    returned_events = []
    attended_events.each do |event|
      returned_events << event if event.date > Time.now
    end
    returned_events
  end

  def previous_events
    returned_events = []
    attended_events.each do |event|
      returned_events << event if event.date < Time.now
    end
    returned_events
  end
end
