# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - deck now initializes with all possible cards in a random order
# Edited by Jack Thompson - 1/25/2020 - changed cardList to an attr_accessor attribute
#
# List with 81 randomly sorted card objects (all possible combinations)

require_relative 'card'

class Deck
  attr_accessor :cardList

  def initialize
    # Initialize card objects
    @cardList = []

    for i in 0...3
      for j in 0...3
        for k in 0...3
          for l in 0...3
            @cardList.append(Card.new(i,j,k,l))
          end
        end
      end
    end

    @cardList = @cardList.shuffle
  end
end