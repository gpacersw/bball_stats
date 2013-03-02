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

ActiveRecord::Schema.define(:version => 20130301232412) do

  create_table "divisions", :force => true do |t|
    t.integer  "league_id"
    t.integer  "season_id"
    t.string   "division_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "divisions", ["league_id"], :name => "index_divisions_on_league_id"
  add_index "divisions", ["season_id"], :name => "index_divisions_on_season_id"

  create_table "leagues", :force => true do |t|
    t.integer  "season_id"
    t.string   "league_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "leagues", ["season_id"], :name => "index_leagues_on_season_id"

  create_table "players", :force => true do |t|
    t.integer  "team_id"
    t.integer  "division_id"
    t.integer  "league_id"
    t.integer  "season_id"
    t.string   "surname"
    t.string   "given_name"
    t.string   "position"
    t.string   "pitch_arm"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "players", ["division_id"], :name => "index_players_on_division_id"
  add_index "players", ["league_id"], :name => "index_players_on_league_id"
  add_index "players", ["season_id"], :name => "index_players_on_season_id"
  add_index "players", ["team_id"], :name => "index_players_on_team_id"

  create_table "seasons", :force => true do |t|
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stats_pitchers", :force => true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.integer  "season_id"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "saves"
    t.integer  "games"
    t.integer  "games_started"
    t.integer  "complete_games"
    t.integer  "shut_outs"
    t.float    "era"
    t.integer  "innings"
    t.integer  "home_runs"
    t.integer  "runs"
    t.integer  "earned_runs"
    t.integer  "hit_batter"
    t.integer  "wild_pitches"
    t.integer  "balk"
    t.integer  "walked_batter"
    t.integer  "struck_out_batter"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "stats_pitchers", ["player_id"], :name => "index_stats_pitchers_on_player_id"
  add_index "stats_pitchers", ["season_id"], :name => "index_stats_pitchers_on_season_id"
  add_index "stats_pitchers", ["team_id"], :name => "index_stats_pitchers_on_team_id"

  create_table "stats_positions", :force => true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.integer  "season_id"
    t.integer  "games"
    t.integer  "games_started"
    t.integer  "at_bats"
    t.integer  "runs"
    t.integer  "hits"
    t.integer  "doubles"
    t.integer  "triples"
    t.integer  "home_runs"
    t.integer  "rbi"
    t.integer  "steals"
    t.integer  "caught_stealing"
    t.integer  "sacrifice_hits"
    t.integer  "sacrifice_flies"
    t.integer  "fielding_errors"
    t.integer  "pb"
    t.integer  "walks"
    t.integer  "struck_out"
    t.integer  "hit_by_pitch"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "stats_positions", ["player_id"], :name => "index_stats_positions_on_player_id"
  add_index "stats_positions", ["season_id"], :name => "index_stats_positions_on_season_id"
  add_index "stats_positions", ["team_id"], :name => "index_stats_positions_on_team_id"

  create_table "teams", :force => true do |t|
    t.integer  "division_id"
    t.integer  "league_id"
    t.integer  "season_id"
    t.string   "team_city"
    t.string   "team_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "teams", ["division_id"], :name => "index_teams_on_division_id"
  add_index "teams", ["league_id"], :name => "index_teams_on_league_id"
  add_index "teams", ["season_id"], :name => "index_teams_on_season_id"

end
