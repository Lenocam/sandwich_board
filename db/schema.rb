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

ActiveRecord::Schema.define(version: 20160615171853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_galleries", force: :cascade do |t|
    t.integer  "gallery_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "album_galleries", ["album_id"], name: "index_album_galleries_on_album_id", using: :btree
  add_index "album_galleries", ["gallery_id"], name: "index_album_galleries_on_gallery_id", using: :btree

  create_table "album_images", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "album_images", ["album_id"], name: "index_album_images_on_album_id", using: :btree
  add_index "album_images", ["image_id"], name: "index_album_images_on_image_id", using: :btree

  create_table "albums", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "name"
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "galleries", ["user_id"], name: "index_galleries_on_user_id", using: :btree

  create_table "gallery_images", force: :cascade do |t|
    t.integer  "gallery_id"
    t.integer  "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "gallery_images", ["gallery_id"], name: "index_gallery_images_on_gallery_id", using: :btree
  add_index "gallery_images", ["image_id"], name: "index_gallery_images_on_image_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "file_id"
    t.string   "height"
    t.string   "width"
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "refile_attachments", force: :cascade do |t|
    t.string "namespace", null: false
  end

  add_index "refile_attachments", ["namespace"], name: "index_refile_attachments_on_namespace", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "album_galleries", "albums"
  add_foreign_key "album_galleries", "galleries"
  add_foreign_key "album_images", "albums"
  add_foreign_key "album_images", "images"
  add_foreign_key "galleries", "users"
  add_foreign_key "gallery_images", "galleries"
  add_foreign_key "gallery_images", "images"
  add_foreign_key "images", "users"
end
