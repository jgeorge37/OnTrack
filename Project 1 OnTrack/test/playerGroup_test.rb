# Created by Jing George - 1/30/2020 - Added test cases for update_score
#
# Test class for PlayerGroup methods.

require "test/unit"
require_relative '../lib/player.rb'
require_relative '../lib/playerGroup.rb'

class TestPlayerGroup < Test::Unit::TestCase

	# Player object to test PlayerGroup methods
  @@playerGroup = PlayerGroup.new
  # Add players to the PlayerGroup object
  @@playerGroup.player_list = [Player.new("p1"), Player.new("p2"), Player.new("p3")]

	# Tests of PlayerGroup.update_score.
  # The following tests only cover cases where the name argument passed
  # to update_score is the name of a player in the game, since cases where
  # the name is not associated with an existing player involves reading in user
  # input.

  # Add one to an existing player's score.
  def test_update_score_simple_pos1
    # Set players of PlayerGroup object
    @@playerGroup.player_list = [Player.new("p1"), Player.new("p2"), Player.new("p3")]
    # Call method under test
    @@playerGroup.update_score("p3", 1)
    # Check for expected scores
    assert_equal(0, @@playerGroup.player_list[0].score)
    assert_equal(0, @@playerGroup.player_list[1].score)
    assert_equal(1, @@playerGroup.player_list[2].score)
  end

  # Add zero to an existing player's score.
  def test_update_score_simple_zero
    # Set players of PlayerGroup object
    @@playerGroup.player_list = [Player.new("p1"), Player.new("p2"), Player.new("p3")]
    # Call method under test
    @@playerGroup.update_score("p2", 0)
    # Check for expected scores
    assert_equal(0, @@playerGroup.player_list[0].score)
    assert_equal(0, @@playerGroup.player_list[1].score)
    assert_equal(0, @@playerGroup.player_list[2].score)
  end

  # Add -1 to an existing player's score.
  def test_update_score_simple_neg1
    # Set players of PlayerGroup object
    @@playerGroup.player_list = [Player.new("p1"), Player.new("p2"), Player.new("p3")]
    # Call method under test
    @@playerGroup.update_score("p2", -1)
    # Check for expected scores
    assert_equal(0, @@playerGroup.player_list[0].score)
    assert_equal(-1, @@playerGroup.player_list[1].score)
    assert_equal(0, @@playerGroup.player_list[2].score)
  end

  # Multiple score adjustments for multiple players.
  def test_update_score_complex
    # Set players of PlayerGroup object
    @@playerGroup.player_list = [Player.new("p1"), Player.new("p2"), Player.new("p3")]
    # Call method under test
    @@playerGroup.update_score("p2", -1)
    @@playerGroup.update_score("p1", -1)
    @@playerGroup.update_score("p1", -6)
    @@playerGroup.update_score("p2", 9)
    @@playerGroup.update_score("p3", -10)
    @@playerGroup.update_score("p3", 0)
    @@playerGroup.update_score("p2", -1)
    @@playerGroup.update_score("p1", 14)
    @@playerGroup.update_score("p2", -1)
    # Check for expected scores
    assert_equal(7, @@playerGroup.player_list[0].score)
    assert_equal(6, @@playerGroup.player_list[1].score)
    assert_equal(-10, @@playerGroup.player_list[2].score)
  end


end
