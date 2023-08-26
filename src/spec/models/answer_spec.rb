require_relative '../../models/init.rb'
require 'sinatra/activerecord'
require '../../models/option.rb'
require '../../models/question.rb'
require '../../models/topic.rb'

describe Answer do

  it "is valid with a topic_id and question_id" do
    topic = Topic.new(nombre: "Samess", descripcion: "prueba nro1", guia: "clasificados")
    question = Question.new(value: 5, description: "140+2", nivel_q: 3, topic_id: 1)
    option = Option.new(description: "142", isCorrect: true, question_id: 1)
    answer = Answer.new(option_id: :option_id, question_id: :question_id)
    expect(answer.valid?).to eq(true)
  end

end