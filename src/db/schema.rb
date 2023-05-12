# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_12_030116) do
  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.string "description"
  end

  create_table "answers", force: :cascade do |t|
    t.integer "option_id"
    t.integer "question_id"
    t.index ["option_id"], name: "index_answers_on_option_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "description"
    t.boolean "isCorrect"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "value"
    t.string "description"
    t.integer "nivel_q"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "topic_id"
    t.index ["topic_id"], name: "index_questions_on_topic_id"
  end

  create_table "questions_options", force: :cascade do |t|
    t.integer "question_id"
    t.integer "option_id"
    t.index ["option_id"], name: "index_questions_options_on_option_id"
    t.index ["question_id"], name: "index_questions_options_on_question_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.integer "total_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_achivements", force: :cascade do |t|
    t.integer "user_id"
    t.integer "achievement_id"
    t.index ["achievement_id"], name: "index_users_achivements_on_achievement_id"
    t.index ["user_id"], name: "index_users_achivements_on_user_id"
  end

  add_foreign_key "answers", "options"
  add_foreign_key "answers", "questions"
  add_foreign_key "questions", "topics"
  add_foreign_key "questions_options", "options"
  add_foreign_key "questions_options", "questions"
  add_foreign_key "users_achivements", "achievements"
  add_foreign_key "users_achivements", "users"
end
