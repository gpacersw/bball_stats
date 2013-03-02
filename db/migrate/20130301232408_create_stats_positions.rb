class CreateStatsPositions < ActiveRecord::Migration
  def change
    create_table :stats_positions do |t|
      t.belongs_to :player
      t.belongs_to :team
      t.belongs_to :season
      t.integer :games
      t.integer :games_started
      t.integer :at_bats
      t.integer :runs
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :rbi
      t.integer :steals
      t.integer :caught_stealing
      t.integer :sacrifice_hits
      t.integer :sacrifice_flies
      t.integer :errors
      t.integer :pb
      t.integer :walks
      t.integer :struck_out
      t.integer :hit_by_pitch

      t.timestamps
    end
    add_index :stats_positions, :player_id
    add_index :stats_positions, :team_id
    add_index :stats_positions, :season_id
  end
end
