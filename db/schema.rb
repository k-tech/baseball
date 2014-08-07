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

ActiveRecord::Schema.define(version: 20140807205821) do

  create_table "battings", force: true do |t|
    t.string   "player_id"
    t.string   "year_id"
    t.string   "league"
    t.string   "team_id"
    t.integer  "games_played"
    t.integer  "at_bats"
    t.integer  "runs"
    t.integer  "hits"
    t.integer  "doubles"
    t.integer  "triples"
    t.integer  "home_runs"
    t.integer  "runs_batted_in"
    t.integer  "stolen_bases"
    t.integer  "caught_stealing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "player_id"
    t.string   "birth_year"
    t.string   "name_first"
    t.string   "name_last"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
