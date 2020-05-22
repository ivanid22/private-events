require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  before :each do
    User.create(name: 'abc', email: 'a@b.com', address: 'def')
    Event.create(title: 'test', date: Time.now, creator: User.first)
  end

  it 'should fail to create an invitation without an attendee' do
    invitation = Invitation.create(attended_event: Event.first)
    expect(invitation.persisted?).to eql(false)
  end

  it 'should fail to create an invitation without an attended event' do
    invitation = Invitation.create(attendee: User.first)
    expect(invitation.persisted?).to eql(false)
  end

  it 'should create and save an invitation when both an attendee and an attended_event are provided' do
    invitation = Invitation.create(attendee: User.first, attended_event: Event.first)
    expect(invitation.persisted?).to eql(true)
  end
end