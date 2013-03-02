class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.belongs_to :league
      t.belongs_to :season
      t.string :division_name

      t.timestamps
    end
    add_index :divisions, :league_id
    add_index :divisions, :season_id
  end
end
