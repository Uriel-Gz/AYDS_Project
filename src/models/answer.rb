class Answer < ActiveRecord::Base
  belongs_to :option

  belongs_to :question

  validates :option_id, numericality: true, presence: true

  validates :question_id, numericality: true, presence: true

end
