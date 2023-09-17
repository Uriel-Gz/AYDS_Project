class User < ActiveRecord::Base
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

end
