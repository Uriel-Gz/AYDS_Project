class CreateAchievement < ActiveRecord::Migration[7.0]
  def change
    create_table :achievements do |t|
      # aL ID lo crea automaticamente
      t.string :name
      t.string :description
      t.integer :point

    end
  end
end
