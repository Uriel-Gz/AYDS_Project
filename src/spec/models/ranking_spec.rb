require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Ranking do
 
  it "is invalid without a user_id" do 
    user = User.new(name: "Veget", email:"1110000010@mail.com", password:"ppaa90034")
    ranking = Ranking.new(score:user.total_score)
    expect(ranking.valid?).to eq(false)
  end

  it "is invalid whitout a score" do
    user = User.new(name: "V", email:"10000010@mail.com", password:"pa00034")
    ranking = Ranking.new(user_id:user.id)
    expect(ranking.valid?).to eq(false)
  end
  
  it "is valid whit a user_id and score" do
    user = User.new(name: "Vegeto", email:"1100010@mail.com", password:"ppaa50034")
    ranking = Ranking.new(score: user.total_score,user_id: user.id)
    expect(ranking.valid?) == (true)
  end

  it "It is invalid if the score is not a number" do
    user = User.new(name: "Vegtte", email:"111030010@mail.com", password:"ppaa70034")
    ranking = Ranking.new(score: "H",user_id: user.id)
    expect(ranking.valid?).to eq(false)
  end

  # it "It is ordered the positions" do
  #   # user = User.new(name: "Vegtte", email:"111030010@mail.com", password:"ppaa70034")
  #   # user2 = User.new(name: "Bridgt", email:"1689@mail.com", password:"passwwod")
  #   ranking = Ranking.create(id: 1,score: 20, user_id: 1, position: 1)
  #   ranking2 = Ranking.create(id: 2,score: 10, user_id: 2, position: 2)
  #   expect(Ranking.find_by(user_id: 1)).position < ((Ranking.find_by(user_id: 2)).position)
  # end

end