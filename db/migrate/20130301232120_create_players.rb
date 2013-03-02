class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :team
      t.belongs_to :division
      t.belongs_to :league
      t.belongs_to :season
      t.string :surname
      t.string :given_name
      t.string :position
      t.string :throws

      t.timestamps
    end
    add_index :players, :team_id
    add_index :players, :division_id
    add_index :players, :league_id
    add_index :players, :season_id
  end
end
