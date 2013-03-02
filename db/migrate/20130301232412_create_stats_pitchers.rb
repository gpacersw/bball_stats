class CreateStatsPitchers < ActiveRecord::Migration
  def change
    create_table :stats_pitchers do |t|
      t.belongs_to :player
      t.belongs_to :team
      t.belongs_to :season
      t.integer :wins
      t.integer :losses
      t.integer :saves
      t.integer :games
      t.integer :games_started
      t.integer :complete_games
      t.integer :shut_outs
      t.float :era
      t.integer :innings
      t.integer :home_runs
      t.integer :runs
      t.integer :earned_runs
      t.integer :hit_batter
      t.integer :wild_pitches
      t.integer :balk
      t.integer :walked_batter
      t.integer :struck_out_batter

      t.timestamps
    end
    add_index :stats_pitchers, :player_id
    add_index :stats_pitchers, :team_id
    add_index :stats_pitchers, :season_id
  end
end
