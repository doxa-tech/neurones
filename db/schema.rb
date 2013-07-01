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

ActiveRecord::Schema.define(:version => 20130630203006) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "subtitle"
    t.integer  "likes",            :default => 0
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "mercury_image_id"
  end

  add_index "articles", ["mercury_image_id"], :name => "index_articles_on_mercury_image_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "thumbup",    :default => 0
    t.integer  "thumbdown",  :default => 0
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "comment_id"
  end

  add_index "comments", ["article_id"], :name => "index_comments_on_article_id"
  add_index "comments", ["comment_id"], :name => "index_comments_on_comment_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "elements", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "theme"
    t.string   "lieu"
    t.datetime "date"
    t.string   "info"
    t.string   "remarque"
    t.integer  "image_id"
    t.integer  "events_type_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "events", ["events_type_id"], :name => "index_events_on_events_type_id"
  add_index "events", ["image_id"], :name => "index_events_on_image_id"

  create_table "events_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "group_cantons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "group_groups", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
    t.string   "website"
    t.string   "street"
    t.string   "city"
    t.integer  "npa"
    t.integer  "canton_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mercury_images", :force => true do |t|
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ownership_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ownerships", :force => true do |t|
    t.integer  "element_id"
    t.integer  "user_id"
    t.integer  "right_id"
    t.integer  "ownership_type_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.boolean  "right_read"
    t.boolean  "right_create"
    t.boolean  "right_update"
    t.boolean  "right_delete"
    t.integer  "id_element"
  end

  add_index "ownerships", ["element_id"], :name => "index_ownerships_on_element_id"
  add_index "ownerships", ["ownership_type_id"], :name => "index_ownerships_on_ownership_type_id"
  add_index "ownerships", ["right_id"], :name => "index_ownerships_on_right_id"
  add_index "ownerships", ["user_id"], :name => "index_ownerships_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "paintings", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "gallery_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "paintings", ["gallery_id"], :name => "index_paintings_on_gallery_id"

  create_table "parents", :force => true do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "parents", ["parent_id"], :name => "index_parents_on_parent_id"
  add_index "parents", ["user_id"], :name => "index_parents_on_user_id"

  create_table "slideshows", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "link"
    t.date     "date_exp"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "email"
    t.integer  "user_type_id"
    t.string   "uid"
    t.string   "gravatar_email"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["uid"], :name => "index_users_on_uid"
  add_index "users", ["user_type_id"], :name => "index_users_on_user_type_id"

end
