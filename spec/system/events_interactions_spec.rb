require 'rails_helper'

RSpec.describe 'events tests', type: :system do
  before :each do
    User.create(name: 'testname', email: 'testemail@domain.com')
    
  end

  it('should create an event') do
    visit('/sign_in')
    fill_in 'Name', with: 'testname'
    click_button 'Sign in'
    visit('/events/new')
    fill_in 'Title', with: 'New title'
    fill_in 'Description', with: 'New description'
    fill_in 'Date', with: Time.now
    click_button 'Create Event'
    expect(page).to have_content('Event created successfully')
  end

  it('should fail to create an event with invalid fields') do
    visit('/sign_in')
    fill_in 'Name', with: 'testname'
    click_button 'Sign in'
    visit('/events/new')
    click_button 'Create Event'
    expect(page).to have_content("Couldn't create event")
  end
  
  it('should fail to create an event when the user is not signed in') do
    visit('/events/new')
    fill_in 'Title', with: 'New title'
    fill_in 'Description', with: 'New description'
    fill_in 'Date', with: Time.now
    click_button 'Create Event'
    expect(page).to have_content('Please sign in to create an event')
  end

end
