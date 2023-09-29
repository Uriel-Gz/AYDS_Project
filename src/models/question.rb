class Question < ActiveRecord::Base
   #relacion de muchos a muchos con user
  has_and_belongs_to_many :users

  #relacion de muchos a 1 con topic
  belongs_to :topic

  #relacion de uno a muchos con options
  has_many :options

  #relacion de uno a uno con answer
  has_one :answer

  validates :value, numericality: true, presence: true

  validates :description, presence: true

  validates :nivel_q, numericality: true, presence: true

  validates :topic_id, presence: true, numericality: true

end

