class Option < ActiveRecord::Base
  #relacion de muchos a muchos con questions
  belongs_to :question

  #relacion de uno a uno con answer
  has_one :answer

end
