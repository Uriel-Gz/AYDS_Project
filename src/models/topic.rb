class Topic < ActiveRecord::Base
  has_many :questions

  validates :nombre, presence: true, length: { minimum: 4 }, uniqueness: true

  validates :descripcion, presence: true, length: { minimum: 10 }, uniqueness: true

  validates :guia, presence: true, length: { minimum: 10 }, uniqueness: true

end


