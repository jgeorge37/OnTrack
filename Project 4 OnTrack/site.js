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
function Card(color, shape, number, shading) {
  /* set object properties according to arguments */
  this.color = color;
  this.shape = shape;
  this.number = number;
  this.shading = shading;
}

/* Deck constructor */
function Deck() {
  /* array of all 81 cards */
  this.card_list = [];

  /* card properties */
  colors = ['red', 'green', 'purple'];
  shapes = ['oval', 'square', 'almond'];
  shading = ['solid', 'open', 'striped'];

  /* create each card with different property combination */
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      for (var k = 1; k <= 3; k++) {
        for (var l = 0; l < 3; l++) {
          this.card_list[this.card_list.length] = new Card(
            colors[i],
            shapes[j],
            k,
            shading[l]
          );
        }
      }
    }
  }

  shuffle(this.card_list);
}

/* Grid constructor */
function Grid() {
  /* array of cards in the grid, not in the Deck */
  this.cardsInGrid = [];

  /* function to add a card to the grid of displayed cards */
  this.addCard = function(card) {
    /* retreive main grid container */
    var grid = document.getElementById('grid_container');
    /* create div element for a card */
    var grid_card = document.createElement('div');
    grid_card.className = 'grid_card';

    /* create appropriate number of shapes to show on card */
    for (var i = 0; i < card.number; i++) {
      var shape = document.createElement('div');
      shape.className = card.color;
      shape.className += ' ' + card.shading;
      shape.className += ' ' + card.shape;
      grid_card.appendChild(shape);
    }
    /* add the card to the main grid container */
    grid.appendChild(grid_card);

    /* add Card object to array of cards in the grid */
    this.cardsInGrid.push(card);
  };

  /* function to remove a card from the grid */
  this.removeCard = function(index) {
    var grid = document.getElementById('grid_container');
    grid.removeChild(grid.childNodes[index]);
    /* remove card from the array of cards */
    this.cardsInGrid.splice(index, 1);
  };

  /* function to remove the grid from its parent node */
  this.removeGrid = function() {
    var grid = document.getElementById('grid_container');
    grid.parentNode.removeChild(grid);
  };

  /* function to create grid div and append to a node */
  this.addGrid = function(node, card_list) {
    var grid = document.createElement('div');
    grid.setAttribute('id', 'grid_container');
    grid.className = 'grid';
    node.appendChild(grid);

    for (var i = 0; i < 12; i++) {
      this.addCard(card_list.shift());
    }
  };
}

/* Function to not display an element */
function hide(target) {
  target.style.display = 'none';
}

/* Function to not display a collection of elements */
function hideAll(collection) {
  for (var i = 0; i < collection.length; i++) {
    hide(collection[i]);
  }
}

/* Function to display an element */
function show(target) {
  target.style.display = 'block';
}
/* function to check if an attribute of a card are the same */
function attribute_check(attr1, attr2, attr3) {
  var result;
  result = attr1 == attr2 && attr1 == attr3;
  result = result || (attr1 != attr2 && attr1 != attr3 && attr2 != attr3);
  return result;
}
/* function that checks if three given cards are a set */
function is_set(card1, card2, card3) {
  var is_set;
  // Call attribute_check method on all 4 attributes for each card.
  is_set = attribute_check(card1.color, card2.color, card3.color);
  is_set = is_set && attribute_check(card1.shape, card2.shape, card3.shape);
  is_set = is_set && attribute_check(card1.number, card2.number, card3.number);
  is_set =
    is_set && attribute_check(card1.shading, card2.shading, card3.shading);
  return is_set;
}
/* funtion to create all combos possible
   Adapated from https://js-algorithms.tutorialhorizon.com/2015/10/23/combinati
   ons-of-an-array/
*/
function create_combos(grid_obj) {
  var i = 0;
  var j = 0;
  var result = [];
  var deckLength = deck.length;
  let power = Math.power;
  combinations = power(2, deckLength);
  for (i = 0; i < combinations; i++) {
    var temp = [];
    for (j = 0; j < deckLength; j++) {
      if (i & power(2, j)) {
        temp.push(grid_obj[j]);
      }
    }
    if (temp.length == 3) {
      result.push(temp);
    }
  }
  return result;
}
/* function that checks if a set is present in the cards on table */
function set_present(grid_obj) {
  currentCombos = create_combos(Grid.cardsInGrid);
  var setPresent = false;
  var count = 0;
  while (setPresent == false && count < currentCombos.length) {
    temp = currentCombos[count];
    if (is_set(temp[0], temp[1], temp[2]) == true) {
      setPresent = true;
    }
    count = count + 1;
  }
  return setPresent;
}

// Created by Snigdha Tiwari 3/17/20

// Return array of 3 cards the computer choose.
function computer_moves(correct_set, table_size) {
  var card_array = new Array(table_size - 1);

  var choices_array = new Array(false, true, false);

  shuffle(choices_array);
  var choice = choices_array.shift();

  if (choice && (!Array.isArray(correct_set) || !correct_set.length)) {
    alert(
      'computer chose: ' +
        correct_set[1] +
        ', ' +
        correct_set[2] +
        ' ,' +
        correct_set[3]
    );
  } else {
    shuffle(card_array);
    var card1 = card_array.shift();

    shuffle(card_array);
    var card2 = card_array.shift();

    shuffle(card_array);
    var card3 = card_array.shift();

    alert('Computer chose: ' + card1 + ' , ' + card2 + ' , ' + card3);
  }
}

/**
 * Shuffles array in place.
 * @param {Array} a items An array containing the items.
 * This function has been adapted from the Fisher-Yates Shuffle Algorithm:
 * https://stackoverflow.com/questions/6274339/how-can-i-shuffle-an-array
 */
function shuffle(arr) {
  var j, x, i;
  for (i = arr.length - 1; i > 0; i--) {
    j = Math.floor(Math.random() * (i + 1));
    x = arr[i];
    arr[i] = arr[j];
    arr[j] = x;
  }
  return arr;
}

/* Created by Jack Hanley
 Method that generates a hint for a player.  Tells the user a potential
 card to use */
function give_hint() {
  var currentCombos = create_combos(Grid.cardsInGrid);
  if (set_present(Grid.cardsInGrid) == false) {
    window.alert('There may not be a set here');
  }

  var flag = false;
  var count = 0;
  while (flag == false) {
    var temp = currentCombos[count];
    if (is_set(temp[0], temp[1], temp[2]) == true) {
      var singleCard1 = temp[0];
      var singleCard2 = temp[1];
      var singleCard3 = temp[2];
      var count = 0;
      var index1 = 0;
      var index2 = 0;
      var index3 = 0;
      while (count < Grid.cardsInGrid) {
        if (singleCard1 == Grid.cardsInGrid[count]) {
          index1 = count + 1;
        } else if (singleCard2 == Grid.cardsInGrid[count]) {
          index2 = count + 1;
        } else if (singleCard3 == Grid.cardsInGrid[count]) {
          index3 = count + 1;
        }
        count = count + 1;
      }
      var hintNum = 2;
      switch (hintNum) {
        case 0:
          window.alert('Card ' + index1 + ' is in a set');
          break;
        case 1:
          window.alert('Cards ' + index1 + ' and ' + index2 + ' are in a set');
          break;
        case 2:
          window.alert(
            'Try using card numbers: ' + index1 + ', ' + index2 + ', ' + index3
          );
          break;
        default:
          break;
      }
      flag = true;
    }
  }
}

class Player {
  constructor(name) {
    this.name = name;
    this.score = 0;
  }
}

window.onload = function() {
  var grid_obj = new Grid();
  var deck = new Deck();
  var player_list = new PlayerGroup();

  /* Get the main menu buttons and main content views */
  var buttons = document.getElementById('menu').getElementsByTagName('button');
  var views = document.getElementsByClassName('view');

  /* addEventListener for displaying appropriate view when each button is clicked */
  for (var i = 0; i < buttons.length; i++) {
    buttons[i].addEventListener('click', function() {
      /* hide old content */
      hideAll(views);
      /* show new content */
      for (var k = 0; k < buttons.length; k++) {
        if (buttons[k] === this) {
          show(views[k + 1]);
        }
      }
    });
  }

  var goBackButtons = this.document.getElementsByClassName('backbutton');
  for (var i = 0; i < goBackButtons.length; i++) {
    goBackButtons[i].addEventListener('click', function() {
      hideAll(views);
      show(document.getElementById('home_view'));
    });
  }

  /* displays home view*/
  show(document.getElementById('home_view'));

  /* This shows the grid of cards in the singleplayer view */
  buttons[0].addEventListener('click', function() {
    var sp_view = document.getElementById('singleplayer_view');
    var player_name = document.createElement('input');
    player_name.type = 'text';
    player_name.placeholder = 'Enter player name';
    sp_view.appendChild(player_name);
    var start = document.createElement('button');
    start.type = 'button';
    start.innerHTML = 'Start';
    sp_view.appendChild(start);
    start.addEventListener('click', function() {
      if (document.getElementById('grid_container') != null) {
        grid_obj.removeGrid();
      }
      grid_obj.addGrid(sp_view, deck.card_list);
    });
  });

  buttons[1].addEventListener('click', function() {
    var menu = document.getElementById('multiplayer_menu_view');
    var game = document.getElementById('multiplayer_game_view');
    var player_container = document.getElementById('player_container');
    menu.style.display = 'block';
    game.style.display = 'none';
    while (player_container.hasChildNodes()) {
      player_container.removeChild(player_container.lastChild);
    }
    document
      .getElementById('fill_members')
      .addEventListener('click', function() {
        var num = document.getElementById('player_number').value;
        while (player_container.hasChildNodes()) {
          player_container.removeChild(player_container.lastChild);
        }
        for (i = 0; i < num; i++) {
          player_container.appendChild(
            document.createTextNode('Player' + (i + 1))
          );
          var input = document.createElement('input');
          input.type = 'text';
          input.className = 'input_player';
          player_container.appendChild(input);
          player_container.appendChild(document.createElement('br'));
        }
      });

    document
      .getElementById('startbutton')
      .addEventListener('click', function() {
        var state = true;
        var inputs = menu.getElementsByClassName('input_player');
        var num = document.getElementById('player_number').value;
        console.log(num);
        for (i = 0; i < inputs.length; i++) {
          if (inputs[i].value == '') {
            state = false;
            window.alert('all inputs need to be filled');
            break;
          }
        }
        if (num <= 1 || num == '') {
          state = false;
          window.alert('Must have more than 1 player');
        }
        if (state) {
          menu.style.display = 'none';
          game.style.display = 'flex';
          if (document.getElementById('grid_container') != null) {
            grid_obj.removeGrid();
          }
          var old_list = document.getElementById('player_list');
          if (old_list) {
            old_list.remove();
          }
          grid_obj.addGrid(game, deck.card_list);
          var inputs = menu.getElementsByClassName('input_player');
          var list = document.createElement('div');
          list.id = 'player_list';
          player_list.player_list = [];
          for (i = 0; i < inputs.length; i++) {
            var new_input = document.createElement('input');
            new_input.type = 'radio';
            new_input.name = 'player';
            new_input.id = inputs[i].value;
            new_input.value = inputs[i].value;
            var name = document.createElement('label');
            var score = document.createElement('label');
            score.htmlFor = inputs[i].value + '_score';
            score.textContent = '0';
            name.htmlFor = inputs[i].value;
            name.textContent = inputs[i].value + ': ';
            list.appendChild(new_input);
            list.appendChild(name);
            list.appendChild(score);
            player_list.player_list[i] = new Player(inputs[i].value);
          }
          game.appendChild(list);
          console.log(player_list);
        }
      });
  });

  //grid_obj.addCard(deck.card_list.shift());

  var exit = false;

  // Main menu
  while (!exit) {
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
    while (!gameOver) {
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
};
