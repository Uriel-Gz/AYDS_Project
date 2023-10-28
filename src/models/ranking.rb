class Ranking < ActiveRecord::Base
  # has_and_belongs_to_many :users

  # relacion de uno a muchos con users
  has_many :users

  validates :score, presence: true, numericality: true

  validates :user_id, presence: true


  def self.update_score(ranking, user)
    ranking.update_column(:score, user.total_score)
  end
end
