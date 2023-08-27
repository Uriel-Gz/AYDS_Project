require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe User do

    it "is valid with a name, email and pasword" do
      user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
      expect(user.valid?).to eq(true)
    end

    it "is invalid without a firstname" do
      user = User.new(email: "santiagovazquez010@gmail.com", password:"pas123")
      expect(user.valid?).to eq(false)
    end

    it "is invalid without an email address" do
      user = User.new(name:"Santioo", password:"pas123")
      expect(user.valid?).to eq(false)
    end

    it "is invalid without a password" do
      user = User.new(name:"Santioo", email:"santiagovazquez010@gmail.com")
      expect(user.valid?).to eq(false)
    end

    it "is invalid with a duplicate email address" do
      user_one = User.create(name: "Juan", email: "juan@gmail.com", password: "pas1234")
      user = User.new(name: "Lucas", email: "juan@gmail.com", password: "pp111")
      expect(user.valid?).to eq(false)
    end

    it "is invalid with a duplicate name" do
      user_one = User.create(name: "Luis", email: "luis@gmail.com", password: "pas1234")
      user = User.new(name: "Luis", email: "pedro@gmail.com", password: "pp111")
      expect(user.valid?).to eq(false)
    end

    it "returns a contact's full name as a string" do
      user = User.new(name: "Santioo", email: "santiagovazquez010@gmail.com")
      user_name = user.name
      expect(user_name).to eq("Santioo")
    end
end

#  describe 'User' do
#  describe 'valid' do
#   describe 'when there is no name' do
#     it 'should be invalid' do
#        u = User.new
#        expect(u.valid?).to eq(false)
#      end
#    end
#  end
#end
