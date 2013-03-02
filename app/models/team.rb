class Team < ActiveRecord::Base
  belongs_to :division
  belongs_to :league
  belongs_to :season
  attr_accessible :team_city, :team_name, :season_id
end
