class CreateRankings < ActiveRecord::Migration[7.0]
  def change
    create_table :rankings do |t|
      t.integer :position
      t.integer :score
      t.references :user, foreign_key: true
    end
  end
end
