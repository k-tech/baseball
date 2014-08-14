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

ActiveRecord::Schema.define(version: 20140813143659) do

  create_table "battings", force: true do |t|
    t.string   "player_id"
    t.string   "year_id"
    t.string   "league"
    t.string   "team_id"
    t.integer  "games_played",               default: 0, null: false
    t.integer  "at_bats",                    default: 0, null: false
    t.integer  "runs",                       default: 0, null: false
    t.integer  "hits",                       default: 0, null: false
    t.integer  "doubles",                    default: 0, null: false
    t.integer  "triples",                    default: 0, null: false
    t.integer  "home_runs",                  default: 0, null: false
    t.integer  "runs_batted_in",             default: 0, null: false
    t.integer  "stolen_bases",               default: 0, null: false
    t.integer  "caught_stealing",            default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "bat_ave",         limit: 24
  end

  create_table "players", force: true do |t|
    t.string   "player_id"
    t.string   "birth_year"
    t.string   "name_first"
    t.string   "name_last"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "most_improved", limit: 24
  end

end
