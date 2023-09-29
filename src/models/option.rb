class Option < ActiveRecord::Base
  #relacion de muchos a muchos con questions
  belongs_to :question

  #relacion de uno a uno con answer
  has_one :answer

  ## validacion
  validates :description, presence: true

  validates :isCorrect, presence: true,inclusion: [true, false]

  validates :question_id, presence: true, numericality: true


end
