class Achievement < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true

  validates :description, presence: true, uniqueness: true

  validates :point, presence: true, uniqueness: true, numericality: true
end
