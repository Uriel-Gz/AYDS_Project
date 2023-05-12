class CreateQuestionsOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions_options do |t|

      t.references :question, foreign_key: true

      t.references :option, foreign_key: true

    end
  end
end
