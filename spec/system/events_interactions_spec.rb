require 'rails_helper'

RSpec.describe 'events tests', type: :system do
  before :each do
    User.create(name: 'testname', email: 'testemail@domain.com')
  end

  it('should create an event') do
    visit('/events/new')
    fill_in 'Title', with: 'New title'
    fill_in 'Description', with: 'New description'
    fill_in 'Date', with: Time.now
    click_button 'Create Event'
    expect(page).to have_content('Creator')
  end

  
end
