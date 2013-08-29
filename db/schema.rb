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

ActiveRecord::Schema.define(version: 20130827233148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pools", force: true do |t|
    t.string   "pool_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.date    "date"
    t.string  "visitor"
    t.string  "home"
    t.string  "time"
    t.integer "week_id"
  end

  add_index "schedules", ["week_id"], name: "index_schedules_on_week_id", using: :btree

  create_table "schedules_users", id: false, force: true do |t|
    t.integer  "schedule_id"
    t.integer  "user_id"
    t.integer  "pool_id"
    t.integer  "week_id"
    t.string   "pick"
    t.string   "winner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules_users", ["schedule_id"], name: "index_schedules_users_on_schedule_id", using: :btree
  add_index "schedules_users", ["user_id"], name: "index_schedules_users_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name", limit: 50
    t.string   "last_name",  limit: 50
    t.string   "email",      limit: 100
    t.string   "password",   limit: 50
    t.string   "image",      limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_pools", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "pool_id"
    t.string   "pool_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_pools", ["pool_id"], name: "index_users_pools_on_pool_id", using: :btree
  add_index "users_pools", ["user_id"], name: "index_users_pools_on_user_id", using: :btree

  create_table "users_weeks", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "week_id"
    t.integer  "pool_id"
    t.integer  "total_games"
    t.integer  "total_wins"
    t.integer  "total_losses"
    t.integer  "win_percentage"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_weeks", ["pool_id"], name: "index_users_weeks_on_pool_id", using: :btree
  add_index "users_weeks", ["user_id"], name: "index_users_weeks_on_user_id", using: :btree
  add_index "users_weeks", ["week_id"], name: "index_users_weeks_on_week_id", using: :btree

  create_table "weeks", force: true do |t|
    t.date     "week_start"
    t.date     "week_end"
    t.boolean  "played",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weeks_pools", id: false, force: true do |t|
    t.integer  "week_id"
    t.integer  "pool_id"
    t.integer  "user_id"
    t.string   "week_winner"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weeks_pools", ["pool_id"], name: "index_weeks_pools_on_pool_id", using: :btree
  add_index "weeks_pools", ["week_id"], name: "index_weeks_pools_on_week_id", using: :btree

end
