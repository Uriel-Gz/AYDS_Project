class Ranking < ActiveRecord::Base
    #has_and_belongs_to_many :users

    #relacion de uno a muchos con users
    has_many :users

end
  