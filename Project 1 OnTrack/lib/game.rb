# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Laid out foundation of program
# Edited by Jing George - 1/26/2020 - Incorporation of new PlayerGroup class
# Edit by Von Mbah - 1/29/2020 - Changed a bit of game logic as well as included replacing cards
# Edited by Jack Thompson - 1/30/2020 - Implemented is_set() method test into main gameplay; option for quit
# Edited by Jack Thompson - 1/30/2020 - Implemented tty-prompt menu options
# Edited by Jing George - 1/30/2020 - Fixed issue with card indexing when calling is_set
# Edited by Von Mbah - 1/30/2020 - Changed prompts now to multi-select
# Edited by Jack Thompson - 2/2/2020 - Implemented main menu functionality, tutorial, settings
# Edited by Snigdha Tiwari- 2/3/2020 - Added breaks in between to make sure that the players can see hints and scores
# Edited by Snigdha Tiwari - 2/3/2020 - Added functionality for a computer player
#
# Controls overall game functionality

require_relative 'computer'
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
    print "\e[H\e[2J"
    playerGroup.player_list = []
    computer_flag = false
    # Get player information
    case prompt.select("Choose: ", %w(Multiplayer Computer))
        when "Multiplayer"
          print "\e[H\e[2J"
          playerGroup.add_players
        when "Computer"
          print "\e[H\e[2J"
          playerGroup.add_computer
          computer_flag = true
          computer_turn = false

        end

  # Place 12 cards on table
    deck = Deck.new
    table = Table.new
    table.fillTable(deck)
    tableView = View.new(table.current_cards)
    gameOver = false
    computer = Computer.new

    until gameOver
      # Displaying the table
      if(visual == "Graphics")
        table.display_table
      else
        tableView.render
      end

      # computer mode and computer's turn
      if computer_flag && computer_turn
        moves = computer.computer_moves(table.correct_set,table.current_cards.size)
        if(table.is_set(table.current_cards[moves[0]-1], table.current_cards[moves[1]-1], table.current_cards[moves[2]-1]))
          # If match, continue out of loop and +1 to player Score
          puts("Congratulations! You've correctly entered a set!")
          playerGroup.update_score("Computer", 1)
          prompt.keypress("Press any key to continue :countdown ...", timeout: 3)
          correctSet = true
          # Replace entered cards
          table.replace_cards(table.current_cards[moves[0]-1], table.current_cards[moves[1]-1], table.current_cards[moves[2]-1], deck)
        else
          # Else, return to prompting and -1 point to player Score
          puts("These cards do not make a set.")
          playerGroup.update_score("Computer", -1)
          prompt.keypress("Press any key to continue :countdown ...", timeout: 3)

        end
        computer_turn = !computer_turn
      else
        # player turn
      case prompt.select("Select an option.", %w(EnterCards NoSet Hint MainMenu))

      when "EnterCards"
        # Prompting the user to select 3 cards
        card_array = []
        choices = (1..table.current_cards.size).to_a
        choices = choices.map(&:to_s)
        while card_array.size != 3 do
          card_array = prompt.multi_select("Select 3 cards.", choices)
          if card_array.size != 3
            puts "Incorrect number of cards selected."
          end
        end
        card1 = card_array[0]
        card2 = card_array[1]
        card3 = card_array[2]

        # Prompt for player's name
        nameList = []
        playerGroup.player_list.each_index do |item|
          nameList.append(playerGroup.player_list[item].name)
        end

        # if computer thhen do not need to select name
        if computer_flag
          name = nameList[1]
        else
          name = prompt.select("Which player is entering the set?", nameList)
        end

        print "\e[H\e[2J"
        puts("You've entered " + card1 + ", " + card2 + ", " + card3 + ".\n")

        # Check if entered cards are a match
        if(table.is_set(table.current_cards[card1.to_i-1], table.current_cards[card2.to_i-1], table.current_cards[card3.to_i-1]))
          # If match, continue out of loop and +1 to player Score
          puts("Congratulations! You've correctly entered a set!")
          playerGroup.update_score(name, 1)
          prompt.keypress("Press any key to continue :countdown ...", timeout: 3)
          correctSet = true
          # Replace entered cards
          table.replace_cards(table.current_cards[card1.to_i-1], table.current_cards[card2.to_i-1], table.current_cards[card3.to_i-1], deck)
        else
          # Else, return to prompting and -1 point to player Score
          puts("These cards do not make a set.")
          playerGroup.update_score(name, -1)
          prompt.keypress("Press any key to continue :countdown ...", timeout: 3)

        end
        computer_turn = !computer_turn

      when "NoSet"
        print "\e[H\e[2J"
        if table.if_no_sets(deck) == -1
           gameOver = true
        end
        prompt.keypress("Press any key to continue :countdown ...", timeout: 3)

      when "Hint"
        print "\e[H\e[2J"
        table.give_hint
        prompt.keypress("Press any key to continue :countdown ...", timeout: 3)
      when "MainMenu"
        print "\e[H\e[2J"
        gameOver = true
      else
        print "\e[H\e[2J"
        puts "Not a menu option"
        prompt.keypress("Press any key to continue :countdown ...", timeout: 3)
      end

      end

    end

    playerGroup.print_game_result
    playerGroup.update_highscore!(playerGroup.player_list)
    print("Press <Enter> to return to Main Menu")
    gets

  when "Tutorial"
    tutorial.display
  when "HighScore"
    print "\e[H\e[2J"
    playerGroup.list_top_players
    print("press enter to quit")
    gets
  when "Settings"
    print "\e[H\e[2J"
    visual = prompt.select("Select an option.", %w(Graphics Table))
  when "Quit"
    exit = true
  else

  end
end

print "\e[H\e[2J"
