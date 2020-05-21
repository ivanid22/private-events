require 'rails_helper'

RSpec.describe User, :type => :model do
    it "should create a new instance of User and persist it" do
      user = User.create(name: 'ivan', email: "email@domain.com")
      expect(User.first.name).to eql('ivan')
    end

    it 'should fail to create two users with the same name' do
      User.create(name: 'ivan')
      new_user = User.create(name: 'Ivan')
      expect(new_user.persisted?).to eql(false)
    end
end