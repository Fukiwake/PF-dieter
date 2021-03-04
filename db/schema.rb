# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_04_082711) do

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "gender", null: false
    t.integer "birthyear", null: false
    t.date "birthdate", null: false
    t.float "height", null: false
    t.float "target_weight", null: false
    t.float "target_body_fat_percentage"
    t.text "introduce"
    t.string "profile_image_id"
    t.boolean "is_deleted", default: false
    t.integer "total_exp", default: 0
    t.integer "month_exp", default: 0
    t.integer "week_exp", default: 0
    t.integer "day_exp", default: 0
    t.boolean "comment_notification", default: true
    t.boolean "favorite_notification", default: true
    t.boolean "chat_notification", default: true
    t.boolean "follow_notification", default: true
    t.boolean "diet_style1", default: false
    t.boolean "diet_style2", default: false
    t.boolean "diet_style3", default: false
    t.boolean "diet_style4", default: false
    t.index ["birthyear"], name: "index_customers_on_birthyear"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["introduce"], name: "index_customers_on_introduce"
    t.index ["name"], name: "index_customers_on_name"
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
    t.index ["target_body_fat_percentage"], name: "index_customers_on_target_body_fat_percentage"
    t.index ["target_weight"], name: "index_customers_on_target_weight"
  end

  create_table "diaries", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "title"
    t.text "body"
    t.float "weight", null: false
    t.float "body_fat_percentage"
    t.date "post_date", null: false
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body"], name: "index_diaries_on_body"
    t.index ["body_fat_percentage"], name: "index_diaries_on_body_fat_percentage"
    t.index ["title"], name: "index_diaries_on_title"
    t.index ["weight"], name: "index_diaries_on_weight"
  end

end
