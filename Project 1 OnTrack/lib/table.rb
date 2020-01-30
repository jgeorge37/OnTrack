# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Added isSet method
# Edited by Jack Thompson - 1/25/2020 - Added initialize and fillTable methods
# Edited by Jack Hanley - 1/27/20 - Added colorCheck, shapeCheck, numberCheck
# and shadingCheck methods.  Ediited isSet methods to include these methods
# Edited by Von Mbah - 


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

  # Adds in 3 more if the user
  # sees no possible sets
  def ifNoSets(deck)
    puts "Replacing 3 cards."
    3.times { @currentCards.append(deck.cardList.shift) }
  end

  # Removes cards that were chosen to be a set and then replace them with new cards if
  # current card list is less than 12 cards
  def replaceCards(first, second, third, deck) 
    @currentCards.delete(first)
    @currentCards.delete(second)
    @currentCards.delete(third)
    fillTable(deck)
  end

  # Created by Jack Thompson - 1/22/20
  # Edited by Jack Hanley - 1/27/20
  # Checks to see if three chosen cards make up a set
  def isSet(card1,card2,card3)
    isSet = false
    # Attribute check. Calls other methods to find if attributes meet criteria
    if (colorCheck==true && shapeCheck==true && numberCheck==true && shadingCheck==true)
      isSet = true
    end
    isSet
  end

  private

  # Created by Jack Hanley - 1/27/20
  # Checks if colors on cards are either all the same or all different
  def colorCheck(card1,card2,card3)
    result = true
    if (card1.color == card2.color && card1.color != card3.color || card1.color == card3.color && card1.color != card2.color || card2.color == card3.color && card2.color != card1.color)
      result = false
    end
    result
  end

  # Created by Jack Hanley - 1/27/20
  # Checks if shape on cards are either all the same or all different
  def shapeCheck(card1,card2,card3)
    result = true
    if (card1.shape == card2.shape && card1.shape != card3.shape || card1.shape == card3.shape && card1.shape != card2.shape || card2.shape == card3.shape && card2.color != card1.color)
      result = false
    end
    result
  end
  # Created by Jack Hanley - 1/27/20
  # Checks if number on cards are either all the same or all different
  def numberCheck(card1,card2,card3)
    result = true
    if (card1.number == card2.number && card1.number != card3.number || card1.number == card3.number && card1.number != card2.number || card2.number == card3.number && card2.number != car1.number)
      result = false
    end
    result
  end

  # Created by Jack Hanley - 1/27/20
  # Checks if shading on cards are either all the same or all different
  def shadingCheck(card1,card2,card3)
    result = true
    if (card1.shading == card2.shading && card1.shading != card3.shading|| card1.shading == card3.shading && card1.shading != card2.shading || card2.shading == card3.shading && card2.shading != card1.shading)
      result = false
    end
    result
  end



  
end
