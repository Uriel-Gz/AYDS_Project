class CreateUsersAchievementsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :achievements_users do |t|
      t.references :user, foreign_key: true, null: false
      t.references :achievement, foreign_key: true, null: false
    end
  end
end
