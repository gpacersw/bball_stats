class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.belongs_to :division
      t.belongs_to :league
      t.belongs_to :season
      t.string :team_city
      t.string :team_name

      t.timestamps
    end
    add_index :teams, :division_id
    add_index :teams, :league_id
    add_index :teams, :season_id
  end
end
