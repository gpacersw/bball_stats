
## GG, TECH_DEBT - depending on future intended features, this could be pulled into StatsPosition class.  Just depends on client side data being displayed.  Right now, these are the only attributes for the demo
class StatsHitter
  attr_accessor :player_id, :avg, :hr, :rbi, :runs, :sb, :ops
end

class StatsPosition < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :season
  ## GG, added player_id at end explicitly b/c of mass asignment error / security
  attr_accessible :at_bats, :caught_stealing, :doubles, :fielding_errors, :games, :games_started, :hit_by_pitch, :hits, :home_runs, :pb, :rbi, :runs, :sacrifice_flies, :sacrifice_hits, :steals, :struck_out, :triples, :walks, :player_id

  ## 
  ## read DB for this player stats, calculate
  def self.get_stats_hitter(player_id)
    sh = StatsHitter.new
    
    sp = StatsPosition.find_by_player_id(player_id)
    return nil if sp.nil?
    #puts sp.inspect

    sh.player_id = sp.player_id

    #AVG, HR, RBI, RUNS, SB, and OPS
    sh.hr   = sp.home_runs
    sh.rbi  = sp.rbi
    sh.runs = sp.runs
    sh.sb   = sp.steals

    # AVG
    # avg = H /AB
    if sp.at_bats.to_f == 0
      sh.avg = 0.0
    else
      sh.avg = sp.hits.to_f / sp.at_bats.to_f
    end

    # OPS
    # ops = AB * (H + BB + HBP) + TB * (AB + BB + SF + HBP) / AB * (AB + BB + SF + HBP)
    # TB = 1B + 2(2B) + 3(3B) + 4(HR)
    singles = sp.hits - sp.home_runs - sp.doubles - sp.triples
    total_bases = singles + 2*(sp.doubles) + 3*(sp.triples) + 4*(sp.home_runs)
    if (sp.at_bats * ( sp.at_bats + sp.walks + sp.sacrifice_flies + sp.hit_by_pitch)) == 0
      sh.ops = 0.0
    else
      sh.ops = (sp.at_bats * ( sp.hits + sp.walks + sp.hit_by_pitch) + 
                total_bases * (sp.at_bats + sp.walks + sp.sacrifice_flies + sp.hit_by_pitch)).to_f / 
        (sp.at_bats * ( sp.at_bats + sp.walks + sp.sacrifice_flies + sp.hit_by_pitch)).to_f
    end

    sh
  end
  
end
