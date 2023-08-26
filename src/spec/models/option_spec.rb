require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Option do

    it "is valid with a name, email and pasword" do
      option = Option.new(description: "4", isCorrect: true, question_id: 1)
      expect(option.valid?).to eq(true)
    end

    it "is invalid without a description" do
      option = Option.new(isCorrect: true,question_id: 1)
      expect(option.valid?).to eq(false)
    end


    it "is invalid without the identifier to the question that corresponds" do
      option = Option.new(description: "4", isCorrect: true)
      expect(option.valid?).to eq(false)
    end

    it "is invalid without the identifier to know if it is true or false" do
      option = Option.new(description: "4",question_id: 1)
      expect(option.valid?).to eq(false)
    end
   
    it "is not valid if the identifier of the question to which it corresponds is not number" do
      option = Option.new(description: "4", isCorrect: true, question_id:"N")
      expect(option.valid?).to eq(false)
    end

    
    it "is invalid without the identifier to the question that corresponds" do
      option = Option.new(description: "4", isCorrect:"F", question_id: 1)
      expect(option.valid?).to eq(false)
    end


end