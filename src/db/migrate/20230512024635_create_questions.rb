class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      # aL ID lo crea automaticamente
      t.integer :value
      t.string :description
      t.integer :nivel_q
      #Crea automáticamente las columnas created_at y updated_at para almacenar la fecha y hora de creación y actualización de cada registro.
      t.timestamps

      t.belongs_to :topic, index: true, foreign_key: true
    end
  end
end
