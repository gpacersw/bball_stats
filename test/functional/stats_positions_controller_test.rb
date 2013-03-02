require 'test_helper'

class StatsPositionsControllerTest < ActionController::TestCase
  setup do
    @stats_position = stats_positions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stats_positions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stats_position" do
    assert_difference('StatsPosition.count') do
      post :create, stats_position: { at_bats: @stats_position.at_bats, caught_stealing: @stats_position.caught_stealing, doubles: @stats_position.doubles, errors: @stats_position.errors, games: @stats_position.games, games_started: @stats_position.games_started, hit_by_pitch: @stats_position.hit_by_pitch, hits: @stats_position.hits, home_runs: @stats_position.home_runs, pb: @stats_position.pb, rbi: @stats_position.rbi, runs: @stats_position.runs, sacrifice_flies: @stats_position.sacrifice_flies, sacrifice_hits: @stats_position.sacrifice_hits, steals: @stats_position.steals, struck_out: @stats_position.struck_out, triples: @stats_position.triples, walks: @stats_position.walks }
    end

    assert_redirected_to stats_position_path(assigns(:stats_position))
  end

  test "should show stats_position" do
    get :show, id: @stats_position
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stats_position
    assert_response :success
  end

  test "should update stats_position" do
    put :update, id: @stats_position, stats_position: { at_bats: @stats_position.at_bats, caught_stealing: @stats_position.caught_stealing, doubles: @stats_position.doubles, errors: @stats_position.errors, games: @stats_position.games, games_started: @stats_position.games_started, hit_by_pitch: @stats_position.hit_by_pitch, hits: @stats_position.hits, home_runs: @stats_position.home_runs, pb: @stats_position.pb, rbi: @stats_position.rbi, runs: @stats_position.runs, sacrifice_flies: @stats_position.sacrifice_flies, sacrifice_hits: @stats_position.sacrifice_hits, steals: @stats_position.steals, struck_out: @stats_position.struck_out, triples: @stats_position.triples, walks: @stats_position.walks }
    assert_redirected_to stats_position_path(assigns(:stats_position))
  end

  test "should destroy stats_position" do
    assert_difference('StatsPosition.count', -1) do
      delete :destroy, id: @stats_position
    end

    assert_redirected_to stats_positions_path
  end
end
