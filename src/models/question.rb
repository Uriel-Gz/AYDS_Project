class Question < ActiveRecord::Base
   #relacion de muchos a muchos con user
  has_and_belongs_to_many :user

  #relacion de muchos a 1 con topic
  belongs_to :topic

  #relacion de uno a muchos con options
  has_many :option

  #relacion de uno a uno con answer
  has_one :answer
end

