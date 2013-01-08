# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130107141522) do

  create_table "games", :force => true do |t|
    t.integer   "user_id"
    t.integer   "story_id"
    t.integer   "page_id"
    t.integer   "fails"
    t.integer   "wins"
    t.integer   "pages"
    t.boolean   "active"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "links", :force => true do |t|
    t.integer   "page_id"
    t.integer   "other_page_id"
    t.string    "text"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
  end

  create_table "microposts", :force => true do |t|
    t.string    "content"
    t.integer   "user_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "pages", :force => true do |t|
    t.integer   "story_id"
    t.string    "title"
    t.text      "text"
    t.boolean   "end"
    t.boolean   "success"
    t.integer   "points"
    t.timestamp "created_at",         :null => false
    t.timestamp "updated_at",         :null => false
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.string    "image_url"
  end

  create_table "ratings", :force => true do |t|
    t.integer   "user_id"
    t.integer   "story_id"
    t.integer   "score"
    t.string    "comment"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer   "follower_id"
    t.integer   "followed_id"
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "stories", :force => true do |t|
    t.string    "image"
    t.string    "title"
    t.integer   "user_id"
    t.timestamp "created_at",         :null => false
    t.timestamp "updated_at",         :null => false
    t.text      "description"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.string    "image_url"
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
    t.string    "password_digest"
    t.string    "remember_token"
    t.boolean   "admin",               :default => false
    t.string    "avatar_file_name"
    t.string    "avatar_content_type"
    t.integer   "avatar_file_size"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
