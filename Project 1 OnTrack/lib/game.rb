# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Laid out foundation of program
# Edited by Jing George - 1/26/2020 - Incorporation of new PlayerGroup class
# Edit by Von Mbah - 1/29/2020 - Changed a bit of game logic as well as included replacing cards
# Edited by Jack Thompson - 1/30/2020 - Implemented is_set() method test into main gameplay; option for quit
# Edited by Jack Thompson - 1/30/2020 - Implemented tty-prompt menu options
# Edited by Jing George - 1/30/2020 - Fixed issue with card indexing when calling is_set
# Edited by Von Mbah - 1/30/2020 - Changed prompts now to multi-select
# Edited by Jack Thompson - 2/2/2020 - Implemented main menu functionality, tutorial, settings
#
# Controls overall game functionality

require_relative 'deck'
require_relative 'player'
require_relative 'playerGroup'
require_relative 'table'
require_relative 'view'
require_relative 'tutorial'
require "tty-prompt"

# Initialize variables


playerGroup = PlayerGroup.new
prompt = TTY::Prompt.new
tutorial = Tutorial.new
exit = false
visual = "Graphics"

# Main menu
while !exit
  print "\e[H\e[2J"
  case prompt.select("Welcome to Set!", %w(Start Tutorial HighScore Settings Quit))
  when "Start"
    playerGroup.playerList = []
    # Get player information
    playerGroup.add_players

  # Place 12 cards on table
    deck = Deck.new
    table = Table.new
    table.fillTable(deck)
    tableView = View.new(table.currentCards)
    gameOver = false

    until gameOver
      # Displaying the table
      if(visual == "Graphics")
        table.display_table
      else
        tableView.render
      end

      case prompt.select("Select an option.", %w(EnterCards NoSet give_hint Quit))
      when "EnterCards"
        # Prompting the user to select 3 cards
        cardArray = []
        choices = (1..table.currentCards.size).to_a
        choices = choices.map(&:to_s)
        while cardArray.size != 3 do
          cardArray = prompt.multi_select("Select 3 cards.", choices)
          if cardArray.size != 3
            puts "Incorrect number of cards selected."
          end
        end
        card1 = cardArray[0]
        card2 = cardArray[1]
        card3 = cardArray[2]

        # Prompt for player's name
        nameList = []
        playerGroup.playerList.each_index do |item|
          nameList.append(playerGroup.playerList[item].name)
        end

        name = prompt.select("Which player is entering the set?", nameList)

        print "\e[H\e[2J"
        puts("You've entered " + card1 + ", " + card2 + ", " + card3 + ".\n")

        # Check if entered cards are a match
        if(table.is_set(table.currentCards[card1.to_i-1], table.currentCards[card2.to_i-1], table.currentCards[card3.to_i-1]))
          # If match, continue out of loop and +1 to player Score
          puts("Congratulations! You've correctly entered a set!")
          playerGroup.update_score(name, 1)
          correctSet = true
          # Replace entered cards
          table.replace_cards(table.currentCards[card1.to_i-1], table.currentCards[card2.to_i-1], table.currentCards[card3.to_i-1], deck)
        else
          # Else, return to prompting and -1 point to player Score
          puts("These cards do not make a set.")
          playerGroup.update_score(name, -1)
        end

      when "NoSet"
        table.if_no_sets(deck)
        if table.if_no_sets(deck) == -1
           gameOver = true
        end

      when "give_hint"
        print "\e[H\e[2J"
        table.give_hint
      when "Quit"
        print "\e[H\e[2J"
        gameOver = true
      else
        print "\e[H\e[2J"
        puts "Not a menu option"
      end

    end

    playerGroup.print_game_result
    playerGroup.update_highscore!(playerGroup.playerList)
    print("Press <Enter> to return to Main Menu")
    gets

  when "Tutorial"
    tutorial.display
  when "HighScore"
    playerGroup.list_top_players
    print("press enter to quit")
    gets
  when "Settings"
    visual = prompt.select("Select an option.", %w(Graphics Table))
  when "Quit"
    exit = true
  else

  end
end

print "\e[H\e[2J"
