class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      # aL ID lo crea automaticamente
      t.string :description
      t.boolean :isCorrect

    end
  end
end
