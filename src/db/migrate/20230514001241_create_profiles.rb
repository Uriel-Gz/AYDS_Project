class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :picture

      t.references :user, foreign_key: true, null: false
    end
  end
end
