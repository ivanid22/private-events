require 'rails_helper'

RSpec.describe User, :type => :model do
    before :each do
      User.create(name: 'host', email: 'a@b.com')
      User.create(name: 'guest', email: 'b@c.com')
      Event.create(title: 'a', date: Time.now, creator: User.first)
      Event.create(title: 'b', date: Time.now, creator: User.first)
      Invitation.create(attendee: User.find(2), attended_event: Event.first)
      Invitation.create(attendee: User.find(2), attended_event: Event.find(2))
    end

    let(:test_user) do
      user = User.create(name: 'TestUser', email: 'testuser@domain.com', address: 'Street name');
      user.attended_events.create(title: 'future test event', date: Time.now + 10.days)
      user.attended_events.create(title: 'past test event', date: Time.now - 10.days)
      user
    end

    it "should create a new instance of User and persist it" do
      user = User.create(name: 'ivan', email: "email@domain.com")
      expect(user.persisted?).to eql(true)
    end

    it 'should fail to create two users with the same name' do
      User.create(name: 'ivan')
      new_user = User.create(name: 'Ivan')
      expect(new_user.persisted?).to eql(false)
    end

    it 'should fail to create two users with the same email' do
      User.create(email: 'ivan@domain.com')
      new_user = User.create(email: 'ivan@domain.com')
      expect(new_user.persisted?).to eql(false)
    end

    it 'should retrieve all attended events for the user' do
      att_events = User.find(2).attended_events
      expect(att_events.length).to eql(2)
    end

    describe '#upcoming_events' do
      it 'should return an array' do
        expect(test_user.upcoming_events.class).to eql(Array)
      end

      it 'should return a non-empty array' do
        expect(test_user.upcoming_events.empty?).to eql(false)
      end

      it 'should return the correct number of upcoming events' do
        expect(test_user.upcoming_events.length).to eql(1)
      end
    end

    describe '#previous_events' do
      it 'should return an array' do
        expect(test_user.previous_events.class).to eql(Array)
      end

      it 'should return a non-empty array' do
        expect(test_user.previous_events.empty?).to eql(false)
      end

      it 'should return the correct number of upcoming events' do
        expect(test_user.previous_events.length).to eql(1)
      end
    end
    
end