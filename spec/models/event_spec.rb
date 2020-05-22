require 'rails_helper'

RSpec.describe Event, :type => :model do

  before :each do
    test_user = User.create(name: 'testuser', email: 'test@domain.com', address: '1234 Street name')
    Event.create(title: 'test event', date: Time.now - 10.days, creator: test_user)
    Event.create(title: 'test event', date: Time.now - 10.days, creator: test_user)
    Event.create(title: 'test event', date: Time.now + 10.days, creator: test_user)
    Event.create(title: 'test event', date: Time.now + 10.days, creator: test_user)
  end

  it 'should fail to create an event without a date' do
    ev = Event.create(title: 'test event')
    expect(ev.persisted?).to eql(false)
  end

  it 'should fail to create an event without a creator' do
    event = Event.create(title: 'title', date: Time.now)
    expect(event.persisted?).to eql(false)
  end

  it 'should retrieve all event attendees' do
    host = User.create(name: 'host', email: 'a@b.com')
    first_guest = User.create(name: 'guest', email: 'b@c.com')
    second_guest = User.create(name: 'guest 2', email: 'c@d.com')
    event = Event.create(title: 'a', date: Time.now, creator: host)
    Invitation.create(attendee: first_guest, attended_event: event)
    Invitation.create(attendee: second_guest, attended_event: event)
    expect(event.attendees.length).to eql(2)
  end

  describe ':past' do
    it 'should return the correct number of past events' do
      expect(Event.past.length).to eql(2)
    end
  end

  describe ':upcoming' do
    it 'should return the correct number of upcoming events' do
      expect(Event.upcoming.length).to eql(2)
    end
  end
end