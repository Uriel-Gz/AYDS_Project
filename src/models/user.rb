class User < ActiveRecord::Base

  #relacion de muchos a muchos con achievement
  has_and_belongs_to_many :achievement




end
