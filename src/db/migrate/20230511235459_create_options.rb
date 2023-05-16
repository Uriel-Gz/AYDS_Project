class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      # aL ID lo crea automaticamente
      t.string :description
      t.boolean :isCorrect
      t.references :question, foreign_key: true, null: false


    end
  end
end
