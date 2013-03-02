#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'optparse'
#require 'Date'
require 'nokogiri'
require 'open-uri'
require 'active_record'

ENV['RAILS_ENV'] = "development"
require '../config/environment.rb'

$stdout.sync = true

## GG, TECH_DEBT - this flag should be pulled into command line options
debug = false



## GG, class to count data and compare to be certain all data is read into DB
class StatsValidate
  attr_accessor :season, :league, :division, :team, :player, :stats_pos, :stats_pitcher

  def initialize
    @season = @league = @division = @team = @player = @stats_pos = @stats_pitcher = 0
  end

  def dump
    puts "seas:#{@season}  leag:#{@league}  div:#{@division}  team:#{@team}  play:#{@player}  spos:#{@stats_pos} spitcher:#{@stats_pitcher}"
    puts "ERR - num players does not == positional stats!" if @player != (@stats_pos + @stats_pitcher)
  end
end


###########################
###########################
###########################
###
### Main start 



options = {}
sfile_name = ""

optparse = OptionParser.new do |opts|
  opts.separator ""

  # Set a banner, displayed at the top
  # of the help screen.
  opts.banner = "Usage: stats_parser.rb [options] ..."
 
  options[:statsFname] = false
  opts.on( '-f', '--fname NAME', 'stats filename must be set !!' ) do |arg|
    options[:statsFname] = true
    sfile_name = arg
    puts "statsFname filename +++#{sfile_name}+++"
  end

  # assumed to have this option.
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end

end



begin
  #l = optparse.parse(ARGV)
  optparse.parse!

  if options.has_value?(true) == false
    ## no args provided, so dump help
    ARGV << "-h"
    optparse.parse(ARGV)
    exit
  end

rescue OptionParser::ParseError
  $stderr.print "Error: " + $! + "\n"
  exit
end

#########################
#########################

##################################
##################################
if options[:statsFname] == false
  puts "stats filename must be set!"
  exit
end


puts "stats filename: #{sfile_name}"

  f = File.open( sfile_name )
  doc = Nokogiri::XML(f)

  ## validate XML
  ## GG, TECH_DEBT - would be best to quickly validate XML on file open


  ## count data for later verify
  ## GG, TECH_DEBT - could be refactored to be more efficient at some point
  stats_val_start = StatsValidate.new
  doc.xpath("//SEASON").each do |node| 
    stats_val_start.season += 1  if !node.at("YEAR").text.nil?
    node.xpath("./LEAGUE").each do |league_node|
      stats_val_start.league += 1  if !node.at("LEAGUE_NAME").text.nil?
      league_node.xpath("./DIVISION").each do |division_node|
        ## GG, TECH_DEBT - divisions repeat across leagues, so they are double counted.  will need to fix
        stats_val_start.division += 1  if !node.at("DIVISION_NAME").text.nil?
        division_node.xpath("./TEAM").each do |team_node|
          stats_val_start.team += 1  if !node.at("TEAM_NAME").text.nil?
          team_node.xpath("./PLAYER").each do |player_node|
            if !node.at("SURNAME").text.nil?
              stats_val_start.player += 1  
              if ( player_node.at('POSITION').text =~ /Pitcher/ )
                stats_val_start.stats_pitcher += 1 
              else
                stats_val_start.stats_pos += 1 
              end
            end
          end
        end
      end
    end
  end
  puts stats_val_start.dump


  ## GG, TECH_DEBT - could be refactored to be more efficient at some point
  stats_val_parse = StatsValidate.new
  doc.xpath("//SEASON").each do |node| 
    season = Season.find_or_create_by_year(:year =>  node.at("YEAR").text)
    season.save
    debug == true ? puts(season.inspect) : print("s")
    stats_val_parse.season += 1 

    node.xpath("./LEAGUE").each do |league_node|
      league = League.find_or_create_by_league_name(:league_name => league_node.at("LEAGUE_NAME").text)
      league.season_id = season.id
      league.save
      debug == true ? puts(league.inspect) : print("l")
      stats_val_parse.league += 1 


      league_node.xpath("./DIVISION").each do |division_node|
        division = Division.find_or_create_by_division_name(:division_name => division_node.at("DIVISION_NAME").text)

        division.season_id = season.id
        division.league_id = league.id
        division.save
        debug == true ? puts(division.inspect) : print("d")
        stats_val_parse.division += 1 
      
        division_node.xpath("./TEAM").each do |team_node|
          team = Team.find_or_create_by_team_name_and_season_id(
                                                            :season_id   => season.id,
                                                            :team_name   => team_node.at("TEAM_NAME").text,
                                                            :team_city   => team_node.at("TEAM_CITY").text)

          team.league_id = league.id
          team.division_id = division.id
          team.save
          debug == true ? puts(team.inspect) : print("t")
          stats_val_parse.team += 1 

          ## player
          team_node.xpath("./PLAYER").each do |player_node|

            ## save player info
            player = Player.find_or_create_by_surname_and_given_name_and_team_id(
                                                                     :team_id     => team.id,
                                                                     :surname     => player_node.at('SURNAME').text,
                                                                     :given_name  => player_node.at('GIVEN_NAME').text,
                                                                     :position    => player_node.at('POSITION').text)
            if !player_node.at('THROWS').nil?
              player.pitch_arm = player_node.at('THROWS').text
            end
            player.season_id = season.id
            player.league_id = league.id
            player.division_id = division.id
            player.save
            debug == true ? puts(player.inspect) : print("p")
            stats_val_parse.player += 1 

            #puts player.inspect
            if ( player_node.at('POSITION').text =~ /Pitcher/ )
              ## pitcher
              stats_pitcher = StatsPitcher.find_or_create_by_player_id(
                                                    :player_id          => player.id,
                                                    :wins               => player_node.at('WINS').text,
                                                    :losses             => player_node.at('LOSSES').text,
                                                    :saves              => player_node.at('SAVES').text,
                                                    :games              => player_node.at('GAMES').text,
                                                    :games_started      => player_node.at('GAMES_STARTED').text,
                                                    :complete_games     => player_node.at('COMPLETE_GAMES').text,
                                                    :shut_outs          => player_node.at('SHUT_OUTS').text,
                                                    :era                => player_node.at('ERA').text,
                                                    :innings            => player_node.at('INNINGS').text,
                                                    :home_runs          => player_node.at('HOME_RUNS').text,
                                                    :runs               => player_node.at('RUNS').text,
                                                    :earned_runs        => player_node.at('EARNED_RUNS').text,
                                                    :hit_batter         => player_node.at('HIT_BATTER').text,
                                                    :wild_pitches       => player_node.at('WILD_PITCHES').text,
                                                    :balk               => player_node.at('BALK').text,
                                                    :walked_batter      => player_node.at('WALKED_BATTER').text,
                                                    :struck_out_batter  => player_node.at('STRUCK_OUT_BATTER').text)
              stats_pitcher.season_id = season.id
              stats_pitcher.team_id   = team.id
              stats_pitcher.save
              stats_val_parse.stats_pitcher += 1 

            else
              stats_pos = StatsPosition.find_or_create_by_player_id(
                                                    :player_id         => player.id,
                                                    :games             => player_node.at('GAMES').text,
                                                    :games_started     => player_node.at('GAMES_STARTED').text,
                                                    :at_bats           => player_node.at('AT_BATS').text,
                                                    :runs              => player_node.at('RUNS').text,
                                                    :hits              => player_node.at('HITS').text,
                                                    :doubles           => player_node.at('DOUBLES').text,
                                                    :triples           => player_node.at('TRIPLES').text,
                                                    :home_runs         => player_node.at('HOME_RUNS').text,
                                                    :rbi               => player_node.at('RBI').text,
                                                    :steals            => player_node.at('STEALS').text,
                                                    :caught_stealing   => player_node.at('CAUGHT_STEALING').text,
                                                    :sacrifice_hits    => player_node.at('SACRIFICE_HITS').text,
                                                    :sacrifice_flies   => player_node.at('SACRIFICE_FLIES').text,
                                                    :fielding_errors   => player_node.at('ERRORS').text,
                                                    :pb                => player_node.at('PB').text,
                                                    :walks             => player_node.at('WALKS').text,
                                                    :struck_out        => player_node.at('STRUCK_OUT').text,
                                                    :hit_by_pitch      => player_node.at('HIT_BY_PITCH').text)
              stats_pos.season_id = season.id
              stats_pos.team_id   = team.id

              ## GG, TECH_DEBT - have a count mismatch when this runs, one less pitcher in the DB, 
              ##   likely due to a pither also being a hitter (national league).  Added error trapping to find the issue, would need to come back to this
              if !stats_pos.save
                puts "ERROR SAVING !! - " + e
              else
                ## save success
                stats_val_parse.stats_pos += 1 
              end
            end ## stats_ position / pitcher

          
          end # player
          puts 
          puts "=================================================================="
          ## uncomment break for debug, shortens the amount the file parses
          #break
        end # team
      end # division
    end # league
  end # season

### validate - count DB objects
stats_val_db = StatsValidate.new
stats_val_db.season = Season.all.count
stats_val_db.league = League.all.count
stats_val_db.division = Division.all.count
stats_val_db.team = Team.all.count
stats_val_db.player = Player.all.count
stats_val_db.stats_pos = StatsPosition.all.count
stats_val_db.stats_pitcher = StatsPitcher.all.count

## GG, TECH_DEBT - divisions repeat across leagues, so they are double counted.  will need to fix
print "START:" 
stats_val_start.dump
print "PARSE:"
stats_val_parse.dump
print "DB:" 
stats_val_db.dump

f.close
