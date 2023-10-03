require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Ranking do

  it "is invalid without a user_id" do
    user = User.new(name: "Veget", email:"1110000010@mail.com", password:"ppaa90034")
    ranking = Ranking.new(score:user.total_score)
    expect(ranking.valid?).to eq(false)
    ranking.destroy
    user.destroy
  end

  it "is invalid whitout a score" do
    user = User.new(name: "V", email:"10000010@mail.com", password:"pa00034")
    ranking = Ranking.new(user_id:user.id)
    expect(ranking.valid?).to eq(false)
    ranking.destroy
    user.destroy
  end

  it "is valid whit a user_id and score" do
    user = User.new(name: "Vegeto", email:"1100010@mail.com", password:"ppaa50034")
    ranking = Ranking.new(score: user.total_score,user_id: user.id)
    expect(ranking.valid?).to eq(false)
    ranking.destroy
    user.destroy

  end

  it "It is invalid if the score is not a number" do
    user = User.new(name: "Vegtte", email:"111030010@mail.com", password:"ppaa70034")
    ranking = Ranking.new(score: "H",user_id: user.id)
    expect(ranking.valid?).to eq(false)
    ranking.destroy
    user.destroy
  end

end
