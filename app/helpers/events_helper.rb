module EventsHelper
  def events_by(user)
    Event.where(creator: user)
  end
end
