class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :nombre
      t.string :descripcion
      t.string :guia
    end
  end
end
