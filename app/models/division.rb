class Division < ActiveRecord::Base
  belongs_to :league
  belongs_to :season
  attr_accessible :division_name
end
