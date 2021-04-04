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

ActiveRecord::Schema.define(version: 2021_04_04_015639) do

  create_table "achievements", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.integer "difficulty", null: false
    t.string "batch", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "blocks", force: :cascade do |t|
    t.integer "blocker_id"
    t.integer "blocked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_id"], name: "index_blocks_on_blocked_id"
    t.index ["blocker_id", "blocked_id"], name: "index_blocks_on_blocker_id_and_blocked_id", unique: true
    t.index ["blocker_id"], name: "index_blocks_on_blocker_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "message"
    t.integer "customer_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_list_diaries", force: :cascade do |t|
    t.integer "diary_id", null: false
    t.integer "check_list_id", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_lists", force: :cascade do |t|
    t.integer "diet_method_id"
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "status", default: 0
    t.integer "genre", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
  end

  create_table "customer_achievements", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "achievement_id", null: false
    t.boolean "achievement_status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "gender"
    t.float "height"
    t.float "target_weight"
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
    t.integer "level", default: 1
    t.boolean "all_notification", default: true
    t.string "provider"
    t.string "uid"
    t.integer "age"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "food_calorie"
    t.integer "activity_calorie"
    t.index ["body"], name: "index_diaries_on_body"
    t.index ["body_fat_percentage"], name: "index_diaries_on_body_fat_percentage"
    t.index ["title"], name: "index_diaries_on_title"
    t.index ["weight"], name: "index_diaries_on_weight"
  end

  create_table "diary_comments", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "diary_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
  end

  create_table "diary_favorites", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diary_images", force: :cascade do |t|
    t.integer "diary_id", null: false
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_diary_images_on_diary_id"
  end

  create_table "diet_method_comments", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "diet_method_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
  end

  create_table "diet_method_favorites", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "diet_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diet_method_images", force: :cascade do |t|
    t.integer "diet_method_id", null: false
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diet_method_id"], name: "index_diet_method_images_on_diet_method_id"
  end

  create_table "diet_methods", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "title", null: false
    t.text "way", null: false
    t.text "attention"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_diet_methods_on_title"
    t.index ["way"], name: "index_diet_methods_on_way"
  end

  create_table "entries", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "level_settings", force: :cascade do |t|
    t.integer "level"
    t.integer "threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id"
    t.integer "visited_id"
    t.integer "diary_id"
    t.integer "diet_method_id"
    t.integer "diary_comment_id"
    t.integer "diet_method_comment_id"
    t.string "action"
    t.boolean "checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chat_id"
    t.integer "diet_method_parent_id"
    t.integer "diary_parent_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.boolean "notification", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "diary_id"
    t.integer "diet_method_id"
    t.integer "diary_comment_id"
    t.integer "diet_method_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visitor_id"
    t.integer "visited_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tries", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "diet_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
