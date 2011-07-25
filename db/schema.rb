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

ActiveRecord::Schema.define(:version => 20110722203837) do

  create_table "activities", :force => true do |t|
    t.string   "type"
    t.integer  "user_a_id"
    t.integer  "user_b_id"
    t.integer  "venue_id"
    t.integer  "event_id"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["event_id"], :name => "index_activities_on_event_id"
  add_index "activities", ["image_id"], :name => "index_activities_on_image_id"
  add_index "activities", ["user_a_id"], :name => "index_activities_on_user_a_id"
  add_index "activities", ["user_b_id"], :name => "index_activities_on_user_b_id"
  add_index "activities", ["venue_id"], :name => "index_activities_on_venue_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "events", :force => true do |t|
    t.integer  "venue_id"
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.time     "start_time"
    t.date     "end_date"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.integer  "user_id"
  end

  add_index "events", ["venue_id"], :name => "index_events_on_venue_id"

  create_table "events_users", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "visited"
    t.boolean  "to_go"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events_users", ["event_id"], :name => "index_events_users_on_event_id"
  add_index "events_users", ["user_id"], :name => "index_events_users_on_user_id"

  create_table "friendships", :force => true do |t|
    t.integer  "user_a_id"
    t.integer  "user_b_id"
    t.boolean  "are_friends", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["user_a_id"], :name => "index_friendships_on_user_a_id"
  add_index "friendships", ["user_b_id"], :name => "index_friendships_on_user_b_id"

  create_table "images", :force => true do |t|
    t.string   "image"
    t.string   "caption"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "sub_categories", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_categories", ["category_id"], :name => "index_sub_categories_on_category_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
    t.boolean  "share_email"
    t.boolean  "share_location"
    t.boolean  "share_activity"
    t.boolean  "post_activity"
    t.boolean  "tweet_activity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_venues", :force => true do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.boolean  "visited"
    t.boolean  "to_go"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_venues", ["user_id"], :name => "index_users_venues_on_user_id"
  add_index "users_venues", ["venue_id"], :name => "index_users_venues_on_venue_id"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["category_id"], :name => "index_venues_on_category_id"
  add_index "venues", ["sub_category_id"], :name => "index_venues_on_sub_category_id"
  add_index "venues", ["user_id"], :name => "index_venues_on_user_id"

end
