require_relative 'spec_helper'

describe Question do

  it "is valid with a description, value and level" do
    question = Question.new(description: "2+2?",value: 12,nivel_q: 1)
    expect(question.valid?).to eq(true)
  end
end