require 'sinatra/activerecord'
require_relative '../../models/init'

describe Answer do
  it 'is valid with a topic_id and question_id' do
    Topic.new(nombre: 'Samess', descripcion: 'prueba nro1', guia: 'clasificados')
    Question.new(value: 5, description: '140+2', nivel_q: 3, topic_id: 1)
    Option.new(description: '142', isCorrect: true, question_id: 1)
    answer = Answer.new(option_id: 1, question_id: 1)
    expect(answer.valid?).to eq(true)
  end
end
