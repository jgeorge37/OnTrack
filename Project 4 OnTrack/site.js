// Created by Jack Thompson 3/3/2020

/*
    Outline from game.rb (Project #1)
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

                # Get player information to choose whether they want to play multiplayer and computer
                case prompt.select("Choose: ", %w(Multiplayer Computer))
                when "Multiplayer"
                        print "\e[H\e[2J"

                        # get the names of the players
                        playerGroup.add_players
                when "Computer"
                        print "\e[H\e[2J"

                        # add the name of the player and computer
                        playerGroup.add_computer
                        computer_flag = true

                        # false as its the players turn first
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
                                playerGroup.update_score("Computer", 3)
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

                                # if computer then do not need to select name from nameList
                                if computer_flag
                                    name = nameList[1]
                                else
                                    name = prompt.select("Which player is entering the set?", nameList)
                                end

                                # print out cards that the player has entered
                                print "\e[H\e[2J"
                                puts("You've entered " + card1 + ", " + card2 + ", " + card3 + ".\n")

                                # Check if entered cards are a match
                                if(table.is_set(table.current_cards[card1.to_i-1], table.current_cards[card2.to_i-1], table.current_cards[card3.to_i-1]))
                                        # If match, continue out of loop and +1 to player Score
                                        puts("Congratulations! You've correctly entered a set!")
                                        playerGroup.update_score(name, 3)
                                        prompt.keypress("Press any key to continue :countdown ...", timeout: 3)
                                        correctSet = true
                                        table.hintNum = 0

                                        # Replace entered cards
                                        table.replace_cards(table.current_cards[card1.to_i-1], table.current_cards[card2.to_i-1], table.current_cards[card3.to_i-1], deck)
                                else
                                        # Else, return to prompting and -1 point to player Score
                                        puts("These cards do not make a set.")
                                        playerGroup.update_score(name, -1)
                                        prompt.keypress("Press any key to continue :countdown ...", timeout: 3)
                                end

                                        computer_turn = !computer_turn

                                        # check for no set
                        when "NoSet"
                                print "\e[H\e[2J"
                                if table.if_no_sets(deck) == -1
                                    gameOver = true
                                end

                                prompt.keypress("Press any key to continue :countdown ...", timeout: 3)
                        when "Hint"
                                # Prompt for player's name
                                nameList = []
                                playerGroup.player_list.each_index do |item|
                                        nameList.append(playerGroup.player_list[item].name)
                                end

                                # if computer then do not need to select name
                                if computer_flag
                                    name = nameList[1]
                                else
                                    name = prompt.select("Which player is using the hint?", nameList)
                                end

                                # gives out the score
                                print "\e[H\e[2J"
                                playerGroup.update_score(name, -1)
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
*/

window.onload = function() {

/* Card constructor */
function Card(color, shape, number, shading){
  this.color = color;
  this.shape = shape;
  this.number = number;
  this.shading = shading;
}

/* Function to not display an element */
function hide(target){
  target.style.display = "none";
}

/* Function to not display a collection of elements */
function hideAll(collection){
  for(var i=0; i<collection.length; i++){
    hide(collection[i]);
  }
}

/* Function to display an element */
function show(target){
  target.style.display = "block";
}

/* Get the main menu buttons and main content views */
var buttons = document.getElementById("menu").getElementsByTagName("button");
var views = document.getElementById("main_content").getElementsByTagName("div");

/* addEventListener for displaying appropriate view when each button is clicked */
for(var i=0; i<buttons.length; i++){
  buttons[i].addEventListener("click", function(){
    /* hide old content */
    hideAll(views);
    /* show new content */
    for(var k=0; k<buttons.length; k++){
      if(buttons[k] === this){
        show(views[k]);
      }
    }
  });
}



var exit = false;

// Main menu
while(!exit) {
        // Display "Welcome to Set!"
        // Options for: (Start Tutorial HighScore Settings Quit)
        // Case Start
                // Prompt for: (Multiplayer Computer)
                // Case Multiplayer
                // Get player names
                // Case Computer
                // Get player names
                // Place 12 cards on table
                var gameOver = false;
                while(!gameOver) {
                        // Display table

                        // Computer turn

                        // Player turn
                        // Prompt for: (EnterCards NoSet Hint MainMenu)
                        // Case EnterCards
                        // Case NoSet
                        // Case Hint
                        // Case MainMenu
                                // Re-display Main Menu
                        gameOver = true;
                }
                // Re-display Main Menu
        // Case Tutorial
                // Display tutorial
        // Case HighScore
                // List high scores table
        // Case Settings
                // Prompt for Visuals: (Graphics Table)
        // Case Quit
                exit = true;
}

}
