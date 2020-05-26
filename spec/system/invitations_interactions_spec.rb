require 'rails_helper'

RSpec.describe 'invitations feature tests', type: :system do
  before :each do
    User.create(name: 'host', email: 'testemail@domain.com')
    User.create(name: 'guest', email: 'guest@test.com')
    Event.create(title: 'test event', creator: User.first, date: Time.now + 10.days)
  end

  it('should create an invitation') do
    visit('/sign_in')
    fill_in 'Name', with: 'host'
    click_button 'Sign in'
    visit('/invitations/new')
    select 'guest', from: 'invitation[attendee_id]'
    select 'test event', from: 'invitation[attended_event_id]'
    click_button 'Create Invitation'
    expect(page).to have_content('Invitation successfully created')
  end
end
