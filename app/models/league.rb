class League < ActiveRecord::Base
  belongs_to :season
  attr_accessible :league_name
end
