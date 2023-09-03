require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Question do

  it "is valid with a description, value and level" do
    topic = Topic.new(nombre: "Samesss", descripcion: "pruebaasdsadsad asd a", guia: "asdasdasd asd asd asdasdasdas")
    question = Question.new(description: "2+22?", value: 10, nivel_q: 1, topic_id: 1)
    user = User.create(name: "Vegeta", email:"10000010@mail.com", password:"pa00034")
    question.users.append(user)  # Asignar el usuario a la pregunta
    expect(question.valid?).to eq(true)
    expect(question.users).to include(user)
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

  it "can have associated users" do
    question = Question.new(description: "What is 2+2?", value: 12, nivel_q: 1)
    user = User.create(name: "Vegeta")
    question.users << user

    expect(question.users).to include(user)

  end

end
