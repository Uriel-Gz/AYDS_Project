class Option < ActiveRecord::Base
  #relacion de muchos a muchos con questions
  has_and_belongs_to_many :questions

  #relacion de uno a uno con answer
  has_one :answer

end
