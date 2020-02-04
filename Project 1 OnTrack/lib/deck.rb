# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - deck now initializes with all possible cards in a random order
# Edited by Jack Thompson - 1/25/2020 - changed card_list to an attr_accessor attribute
#
# List with 81 randomly sorted card objects (all possible combinations)

require_relative 'card'

# Representation of a deck of cards
class Deck
  attr_accessor :card_list

  # Initialize a Deck
  # @return [Self]
  def initialize
    # Initialize card objects
    @card_list = []

    for i in 0...3
      for j in 0...3
        for k in 0...3
          for l in 0...3
            @card_list.append(Card.new(i, j, k, l))
          end

        end

      end

    end

    @card_list = @card_list.shuffle
  end
end
