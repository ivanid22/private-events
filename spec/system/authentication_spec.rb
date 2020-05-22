require "rails_helper"

RSpec.describe "authentication routines", :type => :system do
  before :each do
    User.create(name: "testname", email: "testemail@domain.com")
  end

  it("should diplay an error when trying to create a user with a duplicate name") do
    visit("/users/new")
    fill_in "Name", with: "testname"
    click_button "Create User"
    expect(page).to have_content("error")
  end

  it("should diplay an error when trying to create a user with a duplicate email") do
    visit("/users/new")
    fill_in "Name", with: "unique_name"
    fill_in "Email", with: "testemail@domain.com"
    click_button "Create User"
    expect(page).to have_content("error")
  end

  
end
