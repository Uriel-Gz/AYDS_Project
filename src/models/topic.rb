class Topic < ActiveRecord::Base
  has_many :questions

  validates :nombre, presence: true, length: { minimum: 4 }, uniqueness: true

  validates :descripcion, presence: true, length: { minimum: 10 }, uniqueness: true

  validates :guia, presence: true, length: { minimum: 10 }, uniqueness: true

  validates :img, presence: true

  validates :video, presence: true, uniqueness: true

  def self.get_topic(topic_id)
    find_by(id: topic_id)
  end

  def self.question_levels_count(topic)
    topic.questions.distinct.pluck(:nivel_q).count
  end
end
