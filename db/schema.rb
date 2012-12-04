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

ActiveRecord::Schema.define(:version => 20121203164629) do

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id", "commentable_id"], :name => "index_comments_on_user_id_and_commentable_id"

  create_table "link_users", :force => true do |t|
    t.integer  "link_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "topic_id"
  end

  add_index "link_users", ["link_id", "user_id"], :name => "index_link_users_on_link_id_and_user_id", :unique => true
  add_index "link_users", ["link_id"], :name => "index_link_users_on_link_id"
  add_index "link_users", ["topic_id"], :name => "index_link_users_on_topic_id"
  add_index "link_users", ["user_id"], :name => "index_link_users_on_user_id"

  create_table "links", :force => true do |t|
    t.string   "url_link"
    t.string   "url_heading"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "links", ["created_at"], :name => "index_links_on_created_at"
  add_index "links", ["slug"], :name => "index_links_on_slug", :unique => true
  add_index "links", ["url_link"], :name => "index_links_on_url_link", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "topic_user_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topic_user_relationships", ["topic_id"], :name => "index_topic_user_relationships_on_topic_id"
  add_index "topic_user_relationships", ["user_id", "topic_id"], :name => "index_topic_user_relationships_on_user_id_and_topic_id", :unique => true
  add_index "topic_user_relationships", ["user_id"], :name => "index_topic_user_relationships_on_user_id"

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "topics", ["name"], :name => "index_topics_on_name", :unique => true
  add_index "topics", ["slug"], :name => "index_topics_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",            :default => false
    t.string   "slug"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["user_id", "votable_id"], :name => "index_votes_on_user_id_and_votable_id", :unique => true

end
