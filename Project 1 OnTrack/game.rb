# Created by Jack Thompson - 1/21/2020
# Controls overall game functionality

# Initialize variables
# Card
# Deck
# Player
# Table

# Place 12 cards on table
gameOver = false

while !gameOver do
  # Display
  # Verify that there is a set (if not, add more cards if possible)

  # Prompt for card 1
  puts("Enter the first card.")
  card1 = gets.chomp

  # Prompt for card 2
  puts("Enter the second card.")
  card2 = gets.chomp

  # Prompt for card 3
  puts("Enter the third card.")
  card3 = gets.chomp

  # Check if entered cards are a match
    # If match, continue to step 8 and +1 to player Score
    # Else, return to step 4 and -1 point to player Score
  # Replace entered cards
  # If no more cards/sets, end game
  puts("You've entered " + card1 + ", " + card2 + ", " + card3 + ".\n")
end