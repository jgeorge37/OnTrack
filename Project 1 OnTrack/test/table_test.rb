# Created by Jing George - 1/29/2020
# Edited by Jing George - 1/30/20
#
# Test class for Table methods.

require "test/unit"
require_relative '../lib/table.rb'
require_relative '../lib/card.rb'

class TestTable < Test::Unit::TestCase

	# Table object to test Table methods
  @@table = Table.new

	# Class variables to increase readability of card features.
  # Works as an alternative to using plain digits 0-2 in card initialization.
  @@colors = [0, 1, 2]
  @@shapes = [0, 1, 2]
  @@numbers = [0, 1, 2]
  @@shadings = [0, 1, 2]

	# Tests of Table.is_set.
	# Tests all possible variations of the number of cards that share the same
	# color, shape, number, or shading, excluding cases where duplicate cards
	# would be involved.

  # 3 of same color, 3 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_1_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[1])
    card3 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[2])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_2_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 2 of same number, 0 of same shading.
  def test_is_set_3_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_4_true
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_5_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[0], @@shapes[2], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_6_true
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 3 of same number, 2 of same shading.
  def test_is_set_7_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_8_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 2 of same number, 3 of same shading.
  def test_is_set_9_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[0])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_10_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 2 of same number, 0 of same shading.
  def test_is_set_11_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_12_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[2], @@numbers[2], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_13_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[0], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[0], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_14_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 3 of same number, 3 of same shading.
  def test_is_set_15_true
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[2], @@numbers[0], @@shadings[2])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 3 of same number, 2 of same shading.
  def test_is_set_16_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[2], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_17_true
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[1], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 2 of same number, 3 of same shading.
  def test_is_set_18_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[2], @@numbers[2], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_19_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 2 of same number, 0 of same shading.
  def test_is_set_20_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_21_true
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_22_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_23_true
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 3 of same number, 2 of same shading.
  def test_is_set_24_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_25_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 2 of same number, 3 of same shading.
  def test_is_set_26_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[1], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_27_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[2], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 2 of same number, 0 of same shading.
  def test_is_set_28_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 3 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_29_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 3 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_30_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 3 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_31_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 3 of same number, 3 of same shading.
  def test_is_set_32_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[0], @@shapes[1], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 3 of same number, 2 of same shading.
  def test_is_set_33_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_34_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 2 of same number, 3 of same shading.
  def test_is_set_35_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[0])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_36_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_37_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[0])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_38_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_39_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 2 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_40_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 3 of same number, 3 of same shading.
  def test_is_set_41_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[0], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 3 of same number, 2 of same shading.
  def test_is_set_42_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_43_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 2 of same number, 3 of same shading.
  def test_is_set_44_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[0])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_45_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 2 of same number, 0 of same shading.
  def test_is_set_46_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_47_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_48_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 2 of same color, 0 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_49_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 3 of same number, 3 of same shading.
  def test_is_set_50_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[2], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[0])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 3 of same number, 2 of same shading.
  def test_is_set_51_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_52_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 2 of same number, 3 of same shading.
  def test_is_set_53_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_54_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 2 of same number, 0 of same shading.
  def test_is_set_55_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[0], @@shapes[1], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_56_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[1], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_57_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[2], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 3 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_58_true
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 3 of same number, 3 of same shading.
  def test_is_set_59_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[1], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 3 of same number, 2 of same shading.
  def test_is_set_60_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_61_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[1], @@numbers[1], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 2 of same number, 3 of same shading.
  def test_is_set_62_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_63_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[2], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 2 of same number, 0 of same shading.
  def test_is_set_64_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[2], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[2], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_65_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[2], @@shadings[0])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_66_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 2 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_67_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 3 of same number, 3 of same shading.
  def test_is_set_68_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[1], @@shadings[2])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 3 of same number, 2 of same shading.
  def test_is_set_69_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[1], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 3 of same number, 0 of same shading.
  def test_is_set_70_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 2 of same number, 3 of same shading.
  def test_is_set_71_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[1], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 2 of same number, 2 of same shading.
  def test_is_set_72_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[2], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[1])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 2 of same number, 0 of same shading.
  def test_is_set_73_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 0 of same number, 3 of same shading.
  def test_is_set_74_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[0])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 0 of same number, 2 of same shading.
  def test_is_set_75_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[2])
    # Call method under test
    assert(!@@table.is_set(card1, card2, card3))
  end

  # 0 of same color, 0 of same shape, 0 of same number, 0 of same shading.
  def test_is_set_76_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(@@table.is_set(card1, card2, card3))
  end

end
