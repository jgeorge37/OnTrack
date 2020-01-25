# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Added isSet method
# Edited by Jack Thompson - 1/25/2020 - Added initialize and fillTable methods
#
# Holds current cards on table (pulls from deck)
class Table
  attr_accessor :currentCards

  # Created by Jack Thompson - 1/25/20
  def initialize
    @currentCards = []
  end

  # Created by Jack Thompson - 1/25/20
  def fillTable(deck)
    while @currentCards.size < 12 do
      @currentCards.append(deck.cardList.shift)
    end

    @currentCards.each do |num|
      puts num
    end
  end

  # Created by Jack Thompson - 1/22/20
  #
  # Checks to see if three chosen cards make up a set
  def isSet(card1,card2,card3)
    isSet = true

    # Attribute check
    if (card1.color == card2.color && card1.color != card3.color) || (card1.color == card3.color && card1.color != card2.color)
      isSet = false
    elsif (card1.shape == card2.shape && card1.shape != card3.shape) || (card1.shape == card3.shape && card1.shape != card2.shape)
      isSet = false
    elsif (card1.number == card2.number && card1.number != card3.number) || (card1.number == card3.number && card1.number != card2.number)
      isSet = false
    elsif (card1.shading == card2.shading && card1.shading != card3.shading) || (card1.shading == card3.shading && card1.shading != card2.shading)
      isSet = false
    end

    isSet
  end
end