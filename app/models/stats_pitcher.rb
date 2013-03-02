class StatsPitcher < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :season
  attr_accessible :balk, :complete_games, :earned_runs, :era, :games, :games_started, :hit_batter, :home_runs, :innings, :losses, :runs, :saves, :shut_outs, :struck_out_batter, :walked_batter, :wild_pitches, :wins, :player_id
end
