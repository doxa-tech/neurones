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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160229163516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adeia_action_permissions", force: :cascade do |t|
    t.integer  "adeia_action_id"
    t.integer  "adeia_permission_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "adeia_action_permissions", ["adeia_action_id"], name: "index_adeia_action_permissions_on_adeia_action_id", using: :btree
  add_index "adeia_action_permissions", ["adeia_permission_id"], name: "index_adeia_action_permissions_on_adeia_permission_id", using: :btree

  create_table "adeia_actions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adeia_elements", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adeia_group_users", force: :cascade do |t|
    t.integer  "adeia_group_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "adeia_group_users", ["adeia_group_id"], name: "index_adeia_group_users_on_adeia_group_id", using: :btree
  add_index "adeia_group_users", ["user_id"], name: "index_adeia_group_users_on_user_id", using: :btree

  create_table "adeia_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adeia_permissions", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "adeia_element_id"
    t.integer  "permission_type"
    t.boolean  "read_right",       default: false
    t.boolean  "create_right",     default: false
    t.boolean  "update_right",     default: false
    t.boolean  "destroy_right",    default: false
    t.integer  "resource_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "adeia_permissions", ["adeia_element_id"], name: "index_adeia_permissions_on_adeia_element_id", using: :btree
  add_index "adeia_permissions", ["owner_type", "owner_id"], name: "index_adeia_permissions_on_owner_type_and_owner_id", using: :btree

  create_table "adeia_tokens", force: :cascade do |t|
    t.string   "token"
    t.boolean  "is_valid"
    t.integer  "adeia_permission_id"
    t.date     "exp_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "adeia_tokens", ["adeia_permission_id"], name: "index_adeia_tokens_on_adeia_permission_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "subtitle"
    t.integer  "likes",       default: 0
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "cantons", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "thumbup",    default: 0
    t.integer  "thumbdown",  default: 0
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_id"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree
  add_index "comments", ["comment_id"], name: "index_comments_on_comment_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.datetime "date"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.string   "title"
  end

  add_index "events", ["image_id"], name: "index_events_on_image_id", using: :btree

  create_table "events_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "g_comp_groups", force: :cascade do |t|
    t.integer "group_id"
    t.integer "module_id"
  end

  add_index "g_comp_groups", ["group_id"], name: "index_g_comp_groups_on_group_id", using: :btree
  add_index "g_comp_groups", ["module_id"], name: "index_g_comp_groups_on_module_id", using: :btree

  create_table "g_comp_pages", force: :cascade do |t|
    t.integer "page_id"
    t.integer "comp_group_id"
    t.integer "module_order"
  end

  add_index "g_comp_pages", ["comp_group_id"], name: "index_g_comp_pages_on_comp_group_id", using: :btree
  add_index "g_comp_pages", ["page_id"], name: "index_g_comp_pages_on_page_id", using: :btree

  create_table "g_events", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "date"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "g_galleries", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "date"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "g_galleries", ["group_id"], name: "index_g_galleries_on_group_id", using: :btree

  create_table "g_images", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "g_images", ["group_id"], name: "index_g_images_on_group_id", using: :btree

  create_table "g_module_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "g_modules", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "module_type_id"
    t.integer  "module_id"
    t.text     "description"
    t.string   "image"
  end

  add_index "g_modules", ["module_id"], name: "index_g_modules_on_module_id", using: :btree
  add_index "g_modules", ["module_type_id"], name: "index_g_modules_on_module_type_id", using: :btree

  create_table "g_news", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.date     "date_exp"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "g_pages", force: :cascade do |t|
    t.string   "url"
    t.integer  "page_order"
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "g_pages", ["group_id"], name: "index_g_pages_on_group_id", using: :btree

  create_table "g_paintings", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "g_paintings", ["gallery_id"], name: "index_g_paintings_on_gallery_id", using: :btree

  create_table "g_styles", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "theme"
    t.string   "image"
    t.text     "description"
  end

  create_table "g_texts", force: :cascade do |t|
    t.text     "content"
    t.integer  "text_order"
    t.integer  "page_id"
    t.integer  "comp_page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "g_texts", ["page_id"], name: "index_g_texts_on_page_id", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
    t.string   "website"
    t.string   "street"
    t.string   "city"
    t.integer  "npa"
    t.integer  "canton_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.boolean  "website_activated", default: false
    t.integer  "style_id"
  end

  add_index "groups", ["style_id"], name: "index_groups_on_style_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paintings", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paintings", ["gallery_id"], name: "index_paintings_on_gallery_id", using: :btree

  create_table "slideshows", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.string   "link"
    t.date     "date_exp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "uid"
    t.string   "gravatar_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "adeia_action_permissions", "adeia_actions"
  add_foreign_key "adeia_action_permissions", "adeia_permissions"
  add_foreign_key "adeia_group_users", "adeia_groups"
  add_foreign_key "adeia_group_users", "users"
  add_foreign_key "adeia_permissions", "adeia_elements"
  add_foreign_key "adeia_tokens", "adeia_permissions"
end
