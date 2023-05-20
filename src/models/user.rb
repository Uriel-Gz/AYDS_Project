class User < ActiveRecord::Base
  #relacion de muchos a muchos con achievement
  has_and_belongs_to_many :achievements

  #relacion de muchos a muchos con question
    has_and_belongs_to_many :questions

  #relacion de uno a uno con profile
  has_one :profile

end
