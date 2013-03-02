class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :division
  belongs_to :league
  belongs_to :season
  attr_accessible :given_name, :position, :surname, :pitch_arm, :team_id
end
