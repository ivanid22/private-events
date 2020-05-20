class User < ApplicationRecord
    has_many :created_events, class_name: "Event", foreign_key: "creator_id"
    has_many :invitations, class_name: "Invitation", foreign_key: "attendee_id"
    has_many :attended_events, class_name: "Event", through: :invitations, source: "attended_event"

    def upcoming_events
       returned_events = [] 
       self.attended_events.each do |event|
         returned_events << event if event.date > Time.now
       end
       returned_events
    end

    def previous_events
        returned_events = [] 
        self.attended_events.each do |event|
          returned_events << event if event.date <= Time.now
        end
        returned_events
    end
end

