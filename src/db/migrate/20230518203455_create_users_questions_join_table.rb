class CreateUsersQuestionsJoinTable < ActiveRecord::Migration[7.0]
  def change
      create_table :questions_users do |t|
        t.references :user, foreign_key: true, null: false
        t.references :question, foreign_key: true, null: false
      end
  end
end
