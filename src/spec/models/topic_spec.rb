require_relative '../../models/init.rb'
require 'sinatra/activerecord'

describe Topic do

  it "is valid with a name, description and guide" do
    topic = Topic.new(nombre: "Samess", descripcion: "prueba nro1", guia: "clasificados")
    expect(topic.valid?).to eq(true)
  end
  
  it "is invalid without descritcion" do
    topic = Topic.new(nombre: "Multiplos", guia: "clasificados2")
    expect(topic.valid?).to eq(false)
  end

  it "is invalid without guide" do
    topic = Topic.new(nombre: "Divisores", descripcion: "prueba nro2")
    expect(topic.valid?).to eq(false)
  end

  it "is invalid without name" do
    topic = Topic.new(descripcion: "prueba nro3", guia: "clasificados3")
    expect(topic.valid?).to eq(false)
  end

  it "is invalid with a short name, description and guide" do
    topic = Topic.new(nombre: "Son", descripcion: "prueba nro4", guia: "clasificados4")
    expect(topic.valid?).to eq(false)
  end

  it "is in valid with a name, short description and guide" do
    topic = Topic.new(nombre: "Estadistica", descripcion: "prueba", guia: "clasificados5")
    expect(topic.valid?).to eq(false)
  end

  it "is invalid with a name, description and short guide" do
    topic = Topic.new(nombre: "Sustraccion", descripcion: "prueba nro5", guia: "one")
    expect(topic.valid?).to eq(false)
  end

end
