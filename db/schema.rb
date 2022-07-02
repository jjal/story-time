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

ActiveRecord::Schema[7.0].define(version: 2022_06_16_201600) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "badges_sashes", force: :cascade do |t|
    t.integer "badge_id"
    t.integer "sash_id"
    t.boolean "notified_user", default: false
    t.datetime "created_at", precision: nil
    t.index ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
    t.index ["badge_id"], name: "index_badges_sashes_on_badge_id"
    t.index ["sash_id"], name: "index_badges_sashes_on_sash_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "user_id"
    t.integer "story_id"
    t.integer "page_id"
    t.integer "fails"
    t.integer "wins"
    t.integer "pages"
    t.boolean "active"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "links", force: :cascade do |t|
    t.integer "page_id"
    t.integer "other_page_id"
    t.string "text", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "merit_actions", force: :cascade do |t|
    t.integer "user_id"
    t.string "action_method", limit: 255
    t.integer "action_value"
    t.boolean "had_errors", default: false
    t.string "target_model", limit: 255
    t.integer "target_id"
    t.boolean "processed", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer "action_id"
    t.string "related_change_type", limit: 255
    t.integer "related_change_id"
    t.string "description", limit: 255
    t.datetime "created_at", precision: nil
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer "score_id"
    t.integer "num_points", default: 0
    t.string "log", limit: 255
    t.datetime "created_at", precision: nil
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string "category", limit: 255, default: "default"
  end

  create_table "microposts", force: :cascade do |t|
    t.string "content", limit: 255
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "story_id"
    t.string "title", limit: 255
    t.text "text"
    t.integer "points"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at", precision: nil
    t.string "image_url", limit: 255
    t.string "message", limit: 255
    t.string "type", limit: 255
    t.string "audio", limit: 255
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "story_id"
    t.integer "score"
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "stories", force: :cascade do |t|
    t.string "image", limit: 255
    t.string "title", limit: 255
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "description"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at", precision: nil
    t.string "image_url", limit: 255
    t.integer "status"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "password_digest", limit: 255
    t.string "remember_token", limit: 255
    t.boolean "admin", default: false
    t.string "avatar_file_name", limit: 255
    t.string "avatar_content_type", limit: 255
    t.integer "avatar_file_size"
    t.integer "sash_id"
    t.integer "level", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
