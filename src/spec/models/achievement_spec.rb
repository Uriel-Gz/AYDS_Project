require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Achievement do

  it "is valid with a name, description and point" do
    achievement = Achievement.new(name: "Campeon", description: "completa 16 lecciones", point: 16)
    expect(achievement.valid?).to eq(true)
  end

  it "is invalid without a name" do
    achievement = Achievement.new(description: "completa lecciones", point: 11)
    expect(achievement.valid?).to eq(false)
  end

  it "is invalid without a description" do
    achievement = Achievement.new(name: "Glorioso", point: 12)
    expect(achievement.valid?).to eq(false)
  end

  it "is invalid without a point" do
    achievement = Achievement.new(name: "Rey invicto", description: "completa 13 lecciones")
    expect(achievement.valid?).to eq(false)
  end

  it "is invalid with a short name, description and point" do
    achievement = Achievement.new(name: "Dios", description: "completa 1000 lecciones", point: 1000)
    expect(achievement.valid?).to eq(false)
  end

end
