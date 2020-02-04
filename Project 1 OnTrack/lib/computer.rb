# Created by Snigdha Tiwari 2/3/2020
# Edited by Snigdha Tiwari 2/3/2020 - fixed a bug in the program which picked two of the same cards
# Edited by Snigdha Tiwari 2/4/2020 - added comments about functionality
#

require 'tty-prompt'

require_relative 'playerGroup'


class Computer
  # Created by Snigdha Tiwari 2/3/2020
  # Return an array of three cards the computer choose
  # @param [Array[Card]] correct_set
  #  an array of 3 indexes of correct cards
  # @param [Integer] table_size
  # size of table
  def computer_moves(correct_set,table_size)
    #create array of choices
    card_array = (1..table_size).to_a
    # choose to answer correctly or not
    choice = [false, false, true].shuffle.first
    # if true then return correct else shuffle cards and pick again
    if choice && !correct_set.empty?
      puts "Computer chose #{correct_set.join(',')}"
      correct_set
    else
      # choose 3 random cards from the table and return them
      card1 = card_array.shuffle.first
      # remove an element
      card_array.shift
      card2 = card_array.shuffle.first
      # remove an element
      card_array.shift
      card3 = card_array.shuffle.first
      # print out cards
      puts "Computer chose #{card1.to_s},#{card2.to_s},#{card3.to_s} "
      [card1, card2, card3]

    end

  end
end

