require 'spec_helper'

describe User do
	it "not be valid without a password" do
		User.create(email: "test@test1.com").should_not be_valid
	end

	it "not valid with password length less than 4" do
		User.create(email: "test@test1.com", 
					password: "1").should_not be_valid
	end

	it 'should be a valid user without any game preferences' do
		test = User.create(email: "test@test1.com",password: "12345678")
		game1 = Game.create name:"League of Legends"
		test.games << game1
		test.should be_valid
	end

end
