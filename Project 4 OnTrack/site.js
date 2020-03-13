// Created by Jack Thompson 3/3/2020
// Edited by Jing George 3/3, 3/4/2020: created Card, Deck, Grid/card graphics,
// views' visibility for each button pressed in the main menu.

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


/* Card constructor */
function Card(color, shape, number, shading){
  /* set object properties according to arguments */
  this.color = color;
  this.shape = shape;
  this.number = number;
  this.shading = shading;
}

/* Deck constructor */
function Deck(){
  /* array of all 81 cards */
  this.card_list = [];

  /* card properties */
  colors = ["red", "green", "purple"];
  shapes = ["oval", "square", "almond"];
  shading = ["solid", "open", "striped"];

  /* create each card with different property combination */
  for(var i=0; i<3; i++){
    for(var j=0; j<3; j++){
      for(var k=1; k<=3; k++){
        for(var l=0; l<3; l++){
          this.card_list[this.card_list.length] = new Card(colors[i], shapes[j], k, shading[l]);
        }
      }
    }
  }

  /*
  Shuffle cards in deck.
  Adapated from https://medium.com/@nitinpatel_20236
  /how-to-shuffle-correctly-shuffle-an-array-in-javascript-15ea3f84bfb
  */
  for(var i=this.card_list.length - 1; i>0; i--){
    var j = Math.floor(Math.random() * i);
    var temp = this.card_list[i];
    this.card_list[i] = this.card_list[j];
    this.card_list[j] = temp;
  }
}

/* Grid constructor */
function Grid(){

  /* array of cards in the grid, not in the Deck */
  this.cardsInGrid = [];

  /* function to add a card to the grid of displayed cards */
  this.addCard=function(card) {
    /* retreive main grid container */
    var grid = document.getElementById("grid_container");
    /* create div element for a card */
    var grid_card = document.createElement("div");
    grid_card.className = "grid_card";

    /* create appropriate number of shapes to show on card */
    for(var i=0; i<card.number; i++){
      var shape = document.createElement("div");
      shape.className = card.color;
      shape.className += " " + card.shading;
      shape.className += " " + card.shape;
      grid_card.appendChild(shape);
    }
    /* add the card to the main grid container */
    grid.appendChild(grid_card);

    /* add Card object to array of cards in the grid */
    this.cardsInGrid.push(card);
  }

  /* function to remove a card from the grid */
  this.removeCard=function(index) {
    var grid = document.getElementById("grid_container");
    grid.removeChild(grid.childNodes[index]);
    /* remove card from the array of cards */
    this.cardsInGrid.splice(index, 1);
  }

  /* function to remove the grid from its parent node */
  this.removeGrid=function(){
    var grid = document.getElementById("grid_container");
    grid.parentNode.removeChild(grid);

  }

  /* function to create grid div and append to a node */
  this.addGrid=function(node, card_list){
    var grid = document.createElement("div");
    grid.setAttribute("id", "grid_container");
    node.appendChild(grid);

    for(var i=0; i<12; i++){
      this.addCard(card_list.shift());
    }
  }
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
  target.style.display = "flex";
}

window.onload = function() {

var grid_obj = new Grid();
var deck = new Deck();

/* Get the main menu buttons and main content views */
var buttons = document.getElementById("menu").getElementsByTagName("button");
var views = document.getElementsByClassName("view");

/* addEventListener for displaying appropriate view when each button is clicked */
for(var i=0; i<buttons.length; i++){
  buttons[i].addEventListener("click", function(){
    /* hide old content */
    hideAll(views);
    /* show new content */
    for(var k=0; k<buttons.length; k++){
      if(buttons[k] === this){
        show(views[k+1]);
      }
    }
  });
}

var goBackButtons = this.document.getElementsByClassName("backbutton");
for(var i = 0; i < goBackButtons.length; i++) {
  goBackButtons[i].addEventListener("click", function() {
    hideAll(views);
    document.getElementById("home_view").style.display = "block";
  });
}


/* displays home view*/
document.getElementById("home_view").style.display = "block";

/* This shows the grid of cards in the singleplayer view */
var sp_view = document.getElementById("singleplayer_view");
grid_obj.addGrid(sp_view, deck.card_list);
//grid_obj.addCard(deck.card_list.shift());


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
