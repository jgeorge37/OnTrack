# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Laid out foundation of program
#
# Controls overall game functionality

# Initialize variables
card = Card.new
deck = Deck.new
player = Player.new
table = Table.new

# Place 12 cards on table
gameOver = false

until gameOver do
  # Display table

  # Verify that there is a set (if not, add more cards if possible)
  correctSet = false

  # Prompt for input until correct set is entered
  until correctSet
    # Prompt for card 1
    puts("Enter the first card.")
    card1 = gets.chomp

    # Prompt for card 2
    puts("Enter the second card.")
    card2 = gets.chomp

    # Prompt for card 3
    puts("Enter the third card.")
    card3 = gets.chomp

    puts("You've entered " + card1 + ", " + card2 + ", " + card3 + ".\n")
    # Check if entered cards are a match
      # If match, continue out of loop and +1 to player Score
        correctSet = true
      # Else, return to prompting and -1 point to player Score
  end
  # Replace entered cards

  # If no more cards/sets, end game
end