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

ActiveRecord::Schema.define(version: 20151017161849) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "issue_vote_ships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "category_id", limit: 4
    t.string   "content",     limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "issues", ["category_id"], name: "index_issues_on_category_id", using: :btree

  create_table "legislator_vote_ships", force: :cascade do |t|
    t.integer  "legislator_id", limit: 4
    t.integer  "vote_id",       limit: 4
    t.string   "decision",      limit: 255
    t.string   "conflict",      limit: 255, default: "false"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "legislator_vote_ships", ["legislator_id"], name: "index_legislator_vote_ships_on_legislator_id", using: :btree
  add_index "legislator_vote_ships", ["vote_id"], name: "index_legislator_vote_ships_on_vote_id", using: :btree

  create_table "legislators", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.integer  "le_id",      limit: 4
    t.string   "legislator", limit: 255
    t.integer  "ad",         limit: 4
    t.string   "name",       limit: 255
    t.string   "gender",     limit: 255
    t.string   "party",      limit: 255
    t.string   "in_office",  limit: 255
    t.text     "education",  limit: 65535
    t.text     "experience", limit: 65535
    t.string   "image",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "username",    limit: 255
    t.integer  "user_id",     limit: 4
    t.integer  "location_id", limit: 4,   default: 0
    t.string   "status",      limit: 255, default: "未填寫"
    t.string   "role",        limit: 255, default: "normal"
    t.string   "bio",         limit: 255, default: "未填寫"
    t.string   "occupation",  limit: 255, default: "未填寫"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "profiles", ["location_id"], name: "index_profiles_on_location_id", using: :btree
  add_index "profiles", ["status"], name: "index_profiles_on_status", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "raw_legislator_votes", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.integer  "decision",   limit: 4
    t.string   "conflict",   limit: 255, default: "false"
    t.string   "legislator", limit: 255
    t.string   "vote",       limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "raw_legislators", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.integer  "le_id",      limit: 4
    t.string   "legislator", limit: 255
    t.integer  "ad",         limit: 4
    t.string   "name",       limit: 255
    t.string   "gender",     limit: 255
    t.string   "party",      limit: 255
    t.string   "in_office",  limit: 255
    t.text     "education",  limit: 65535
    t.text     "experience", limit: 65535
    t.string   "image",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "raw_votes", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.string   "uid",        limit: 255
    t.string   "sitting_id", limit: 255
    t.string   "vote_seq",   limit: 255
    t.text     "content",    limit: 16777215
    t.string   "conflict",   limit: 255
    t.string   "results",    limit: 255
    t.string   "result",     limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "fb_uid",                 limit: 255
    t.string   "fb_token",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.string   "url",              limit: 255
    t.string   "uid",              limit: 255
    t.text     "original_content", limit: 16777215
    t.text     "new_content",      limit: 16777215
    t.string   "conflict",         limit: 255
    t.string   "result",           limit: 255
    t.integer  "category_id",      limit: 4
    t.string   "user_id",          limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "votes", ["category_id"], name: "index_votes_on_category_id", using: :btree

end
