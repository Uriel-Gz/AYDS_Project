class User < ActiveRecord::Base


  has_secure_password
  #relacion de muchos a muchos con achievement
  has_and_belongs_to_many :achievements

  #relacion de muchos a muchos con question
  has_and_belongs_to_many :questions

  #relacion de uno a uno con profile
  has_one :profile

  #relacion de muchos a 1 con rancking
  belongs_to :ranking


  ## validacion
  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  validates :email, presence: true, uniqueness: true

  validates :password, presence: true


  def self.fetch_user(user_id)
    find_by(id: user_id)
  end

  def self.add_points(user, points)
    result = user.total_score + points
    user.update_column(:total_score, result)
  end
end
