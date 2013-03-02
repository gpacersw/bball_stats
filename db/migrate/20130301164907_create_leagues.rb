class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.belongs_to :season
      t.string :league_name

      t.timestamps
    end
    add_index :leagues, :season_id
  end
end
