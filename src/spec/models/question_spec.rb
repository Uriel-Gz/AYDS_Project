require_relative '../../models/init.rb'
require 'sinatra/activerecord'

describe Question do

  it "is valid with a description, value and level" do
    question = Question.new(description: "2+2?", value: 12, nivel_q: 1)
    expect(question.valid?).to eq(true)
  end

  it "is invalid without a description" do
    question = Question.new(value: 12, nivel_q: 1)
    expect(question.valid?).to eq(false)
  end

  it "is invalid without a value" do
    question = Question.new(description: "2+2?", nivel_q: 1)
    expect(question.valid?).to eq(false)
  end

  it "is invalid without a level" do
    question = Question.new(description: "2+2?", value: 12)
    expect(question.valid?).to eq(false)
  end

end
