require 'test_helper'

class StatsPitchersControllerTest < ActionController::TestCase
  setup do
    @stats_pitcher = stats_pitchers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stats_pitchers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stats_pitcher" do
    assert_difference('StatsPitcher.count') do
      post :create, stats_pitcher: { balk: @stats_pitcher.balk, complete_games: @stats_pitcher.complete_games, earned_runs: @stats_pitcher.earned_runs, era: @stats_pitcher.era, games: @stats_pitcher.games, games_started: @stats_pitcher.games_started, hit_batter: @stats_pitcher.hit_batter, home_runs: @stats_pitcher.home_runs, innings: @stats_pitcher.innings, losses: @stats_pitcher.losses, runs: @stats_pitcher.runs, saves: @stats_pitcher.saves, shut_outs: @stats_pitcher.shut_outs, struck_out_batter: @stats_pitcher.struck_out_batter, walked_batter: @stats_pitcher.walked_batter, wild_pitches: @stats_pitcher.wild_pitches, wins: @stats_pitcher.wins }
    end

    assert_redirected_to stats_pitcher_path(assigns(:stats_pitcher))
  end

  test "should show stats_pitcher" do
    get :show, id: @stats_pitcher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stats_pitcher
    assert_response :success
  end

  test "should update stats_pitcher" do
    put :update, id: @stats_pitcher, stats_pitcher: { balk: @stats_pitcher.balk, complete_games: @stats_pitcher.complete_games, earned_runs: @stats_pitcher.earned_runs, era: @stats_pitcher.era, games: @stats_pitcher.games, games_started: @stats_pitcher.games_started, hit_batter: @stats_pitcher.hit_batter, home_runs: @stats_pitcher.home_runs, innings: @stats_pitcher.innings, losses: @stats_pitcher.losses, runs: @stats_pitcher.runs, saves: @stats_pitcher.saves, shut_outs: @stats_pitcher.shut_outs, struck_out_batter: @stats_pitcher.struck_out_batter, walked_batter: @stats_pitcher.walked_batter, wild_pitches: @stats_pitcher.wild_pitches, wins: @stats_pitcher.wins }
    assert_redirected_to stats_pitcher_path(assigns(:stats_pitcher))
  end

  test "should destroy stats_pitcher" do
    assert_difference('StatsPitcher.count', -1) do
      delete :destroy, id: @stats_pitcher
    end

    assert_redirected_to stats_pitchers_path
  end
end
