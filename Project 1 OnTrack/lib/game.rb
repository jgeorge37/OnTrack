# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Laid out foundation of program
# Edited by Jing George - 1/26/2020 - Incorporation of new PlayerGroup class
# Edit by Von Mbah - 1/29/2020 - Changed a bit of game logic as well as included replacing cards
# Controls overall game functionality

require_relative 'deck'
require_relative 'player'
require_relative 'playerGroup'
require_relative 'table'
require_relative 'view'

# Initialize variables
deck = Deck.new
table = Table.new
playerGroup = PlayerGroup.new

# Get player information
playerGroup.addPlayers

# Place 12 cards on table
table.fillTable(deck)
tableView = View.new(table.currentCards)
gameOver = false

until gameOver do
  # Display table
  
  # Verify that there is a set (if not, add more cards if possible)
  correctSet = false

  # Prompt for input until correct set is entered
  until correctSet
    tableView.render
    # Prompt for card 1
    puts("Enter the first card.")
    card1 = gets.chomp

    # Prompt for card 2
    puts("Enter the second card.")
    card2 = gets.chomp

    # Prompt for card 3
    puts("Enter the third card.")
    card3 = gets.chomp

    # Prompt for player's name
    puts("Enter your name.")
    name = gets.chomp

    puts("You've entered " + card1 + ", " + card2 + ", " + card3 + ".\n")

    if card1 == "n" || card2 == "n" || card3 =="n"
      table.ifNoSets(deck)
    else
    # Check if entered cards are a match
      # If match, continue out of loop and +1 to player Score
        playerGroup.updateScore(name, 1)
        correctSet = true
      # Else, return to prompting and -1 point to player Score
          # playerGroup.updateScore(name, -1)
    end
  end
  # Replace entered cards
  table.replaceCards(table.currentCards[card1.to_i-1], table.currentCards[card2.to_i-1], table.currentCards[card3.to_i-1], deck)
  # If no more cards/sets, end game

end

playerGroup.printGameResult
