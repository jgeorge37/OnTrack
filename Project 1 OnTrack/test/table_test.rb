# Created by Jing George - 1/29/2020
#
#

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

	# Tests of Table.isSet.
	# Tests all possible variations of the number of cards that share the same
	# color, shape, number, or shading, excluding cases where duplicate cards
	# would be involved.

  # 3 of same color, 3 of same shape, 3 of same number, 0 of same shading.
  def test_isSet_1_true
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[1])
    card3 = Card.new(@@colors[0], @@shapes[0], @@numbers[0], @@shadings[2])
    # Call method under test
    assert(@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 2 of same number, 2 of same shading.
  def test_isSet_2_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 2 of same number, 0 of same shading.
  def test_isSet_3_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 0 of same number, 3 of same shading.
  def test_isSet_4_true
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 0 of same number, 2 of same shading.
  def test_isSet_5_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[0], @@shapes[2], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 3 of same shape, 0 of same number, 0 of same shading.
  def test_isSet_6_true
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 3 of same number, 2 of same shading.
  def test_isSet_7_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[0], @@shapes[2], @@numbers[1], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 3 of same number, 0 of same shading.
  def test_isSet_8_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 2 of same number, 3 of same shading.
  def test_isSet_9_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[0])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 2 of same number, 2 of same shading.
  def test_isSet_10_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 2 of same number, 0 of same shading.
  def test_isSet_11_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 0 of same number, 3 of same shading.
  def test_isSet_12_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[2], @@numbers[2], @@shadings[2])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 0 of same number, 2 of same shading.
  def test_isSet_13_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[0], @@numbers[1], @@shadings[2])
    card2 = Card.new(@@colors[0], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[0], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 2 of same shape, 0 of same number, 0 of same shading.
  def test_isSet_14_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 3 of same number, 3 of same shading.
  def test_isSet_15_true
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[2], @@numbers[0], @@shadings[2])
    # Call method under test
    assert(@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 3 of same number, 2 of same shading.
  def test_isSet_16_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[2], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 3 of same number, 0 of same shading.
  def test_isSet_17_true
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[2], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[2], @@numbers[2], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[1], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 2 of same number, 3 of same shading.
  def test_isSet_18_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[0], @@shadings[2])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[1], @@shapes[2], @@numbers[2], @@shadings[2])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 2 of same number, 2 of same shading.
  def test_isSet_19_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 2 of same number, 0 of same shading.
  def test_isSet_20_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 0 of same number, 3 of same shading.
  def test_isSet_21_true
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 0 of same number, 2 of same shading.
  def test_isSet_22_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[1])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 3 of same color, 0 of same shape, 0 of same number, 0 of same shading.
  def test_isSet_23_true
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[1], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(@@table.isSet(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 3 of same number, 2 of same shading.
  def test_isSet_24_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 3 of same number, 0 of same shading.
  def test_isSet_25_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[2], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[2], @@numbers[0], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 2 of same number, 3 of same shading.
  def test_isSet_26_false
    # Create card objects
    card1 = Card.new(@@colors[0], @@shapes[1], @@numbers[1], @@shadings[1])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[1], @@shadings[1])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[1])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 2 of same number, 2 of same shading.
  def test_isSet_27_false
    # Create card objects
    card1 = Card.new(@@colors[1], @@shapes[1], @@numbers[2], @@shadings[0])
    card2 = Card.new(@@colors[2], @@shapes[1], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[1], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end

	# 2 of same color, 3 of same shape, 2 of same number, 0 of same shading.
  def test_isSet_28_false
    # Create card objects
    card1 = Card.new(@@colors[2], @@shapes[0], @@numbers[0], @@shadings[1])
    card2 = Card.new(@@colors[1], @@shapes[0], @@numbers[0], @@shadings[2])
    card3 = Card.new(@@colors[2], @@shapes[0], @@numbers[2], @@shadings[0])
    # Call method under test
    assert(!@@table.isSet(card1, card2, card3))
  end



end
