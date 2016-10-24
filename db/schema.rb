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

ActiveRecord::Schema.define(version: 20161020064120) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "behavior"
    t.string   "object"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string   "card_id"
    t.string   "password_disgest"
    t.float    "balance"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["card_id"], name: "index_bank_accounts_on_card_id", unique: true
  end

  create_table "book_tours", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tour_id"
    t.integer  "people_number"
    t.string   "requirement"
    t.boolean  "is_pay",        default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["tour_id"], name: "index_book_tours_on_tour_id"
    t.index ["user_id"], name: "index_book_tours_on_user_id"
  end

  create_table "category_reviews", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_tours", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "images_tours", force: :cascade do |t|
    t.integer  "tour_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["tour_id"], name: "index_images_tours_on_tour_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_likes_on_review_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tour_id"
    t.integer  "star_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["tour_id"], name: "index_ratings_on_tour_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_review_id"
    t.string   "title"
    t.string   "content"
    t.boolean  "is_confirm",         default: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["category_review_id"], name: "index_reviews_on_category_review_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tours", force: :cascade do |t|
    t.integer  "category_tour_id"
    t.string   "name"
    t.string   "schedule"
    t.string   "place_departure"
    t.string   "time"
    t.integer  "people_number"
    t.string   "transport"
    t.float    "price"
    t.string   "content"
    t.date     "time_start"
    t.float    "rating"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["category_tour_id"], name: "index_tours_on_category_tour_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "",    null: false
    t.string   "encrypted_password",  default: "",    null: false
    t.string   "name"
    t.boolean  "is_admin",            default: false
    t.string   "avatar"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
