# Created by Jack Thompson - 1/21/2020
#
# List with 81 randomly sorted card objects (all possible combinations)

require_relative 'card'

class Deck
  def initialize
    # Initialize card objects
    cardList = []

    for i in 0...3
      for j in 0...3
        for k in 0...3
          for l in 0...3
            cardList.append(Card.new(i,j,k,l))
          end
        end
      end
    end

    cardList.shuffle()
  end
end