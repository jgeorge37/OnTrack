# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Added isSet method
# Edited by Jack Thompson - 1/25/2020 - Added initialize and fillTable methods
# Edited by Jack Hanley - 1/27/20 - Added colorCheck, shapeCheck, numberCheck
# and shadingCheck methods.  Edited isSet methods to include these methods
# Edited by Von Mbah -
# Edited by Jing George - 1/29/20 - Changed colorCheck, shapeCheck, numberCheck,
# Edited by Jack Thompson - 1/30/2020 - Removed debug print message
# 
# and shadingCheck methods to attributeCheck method.
require_relative 'ascii'

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
    disp = Ascii.new

    for line in 1..8 do
     for item in 0...6 do
       disp.printByLine(@currentCards[item], line)
        print("   ")
     end
     puts
    end

    for line in 1..8 do
      for item in 6...12 do
        disp.printByLine(@currentCards[item], line)
        print("   ")
      end
      puts
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
  # Edited by Jing George - 1/29/20
  # Checks to see if three chosen cards make up a set
  def isSet(card1,card2,card3)
    # Call attributeCheck method on all 4 attributes for each card.
    isSet = attributeCheck(card1.color, card2.color, card3.color)
    isSet = isSet && attributeCheck(card1.shape, card2.shape, card3.shape)
    isSet = isSet && attributeCheck(card1.number, card2.number, card3.number)
    isSet = isSet && attributeCheck(card1.shading, card2.shading, card3.shading)
    isSet
  end

  private
  # Created by Jing George - 1/29/20
  # Returns true if all given attributes are either all matching or all different,
  # returns false otherwise (i.e. only two match).
  def attributeCheck(attr1, attr2, attr3)
    result = (attr1 == attr2 && attr1 == attr3)
    result = result || (attr1 != attr2 && attr1 != attr3 && attr2 != attr3)
    result
  end

  # Created by Jack Hanley - 1/30/20 
  # Checks to see if a set is possible given current cards
  def noSet(currentCards)
     currentCombos.new
     currentCombos = @currentCards.combination(3).to_a
     setPresent = false
     count = 0
     while setPresent==false && count<currentCombos.length do
	temp = currentCombos[count]
	if (isSet(temp[0],temp[1],temp[2]) == true)
		setPresent=true
	end
	count = count + 1
     end
     setPresent
  end
  
 #  Created by Jack Hanley
 #  Method that generates a hint for a player.  Tells the user a potential 
 #  card to use
 def hintGenerator(currentCards)
 	currentCombos.new
	currentCombos = @currentCards.combination(3).to_a
	if (noSet(@currentCards) == true)
		puts "There may not be any sets to find within these cards."
	end 
	flag = false
	count = 0 
	until flag == true 
		temp = currentCombos[count]
		if (isSet(temp[0],temp[1],temp[2]) == true)
			singleCard = temp[0]
			puts "Try using card with color: " + singleCard.color
			flag = true
		end
		count = count + 1
	end
   end
end
