class CreateUsersQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :users_questions do |t|

      t.references :user, foreign_key:true 

      t.references :question, foreign_key:true
    end
  end
end
