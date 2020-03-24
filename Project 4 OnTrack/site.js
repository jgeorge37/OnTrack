// Created by Jack Thompson 3/3/2020
// Edited by Jing George 3/3, 3/4/2020: created Card, Deck, Grid/card graphics,
// views' visibility for each button pressed in the main menu.

var CPU_turn = true;
var guessArray = [];
var deckCards = [];
var cardsInGrid = [];
/* Grid constructor */
function Grid() {
  var players;

  /* function to remove a card from the grid */
  this.removeCard = function(guessArray, card_list) {
    var grid = document.getElementById('grid_container');
    console.log(guessArray);
    console.log(grid.childNodes);
    for (let i = 0; i < guessArray.length; i++) {
      for (let j = 0; i < cardsInGrid.length; j++) {
        if (guessArray[i] == cardsInGrid[j]) {
          console.log(j);
          console.log(grid.childNodes[j]);
          grid.removeChild(grid.childNodes[j]);
          cardsInGrid.splice(j, 1);
          j = 0;
          break;
        }
      }
    }
    while (grid.childNodes.length < 12 && card_list.length > 0) {
      addCardToGrid(this, card_list.shift(), players);
    }
  };

  /* function to remove the grid from its parent node */
  this.removeGrid = function() {
    var grid = document.getElementById('grid_container');
    grid.parentNode.removeChild(grid);
  };

  /* function to create grid div and append to a node */
  this.addGrid = function(node, card_list, player_list) {
    players = player_list;
    var grid = document.createElement('div');
    grid.setAttribute('id', 'grid_container');
    grid.className = 'grid';
    node.appendChild(grid);

    for (var i = 0; i < 12; i++) {
      addCardToGrid(this, card_list.shift(), players);
    }
  };
}

function addCardToGrid(grid_obj, card, players) {
  /* retreive main grid container */
  var grid = document.getElementById('grid_container');
  /* create div element for a card */
  var grid_card = document.createElement('div');
  grid_card.className = 'grid_card';

  grid_card.addEventListener('click', function() {
    if (!guessArray.includes(card)) {
      guessArray.push(card);
      grid_card.style.border = '3px solid red';
      if (guessArray.length == 3) {
        if (is_set(guessArray)) {
          grid_obj.removeCard(guessArray, deckCards);
          if (
            document.getElementById('singleplayer_view').style.display != 'none'
          ) {
            players.player_list[0].score += 3;
            document.getElementById(
              players.player_list[0].name + '_score'
            ).innerText = players.player_list[0].score;
          } else {
            var inputs = document
              .getElementById('player_list')
              .getElementsByTagName('input');
            for (i = 0; i < inputs.length - 1; i++) {
              if (inputs[i].checked) {
                players.player_list[i].score += 3;
                document.getElementById(
                  players.player_list[i].name + '_score'
                ).innerText = players.player_list[i].score;
                break;
              }
            }
          }
        } else {
          if (
            document.getElementById('singleplayer_view').style.display != 'none'
          ) {
            players.player_list[0].score -= 1;
            document.getElementById(
              players.player_list[0].name + '_score'
            ).innerText = players.player_list[0].score;
          } else {
            var inputs = document
              .getElementById('player_list')
              .getElementsByTagName('input');
            for (i = 0; i < inputs.length - 1; i++) {
              if (inputs[i].checked) {
                players.player_list[i].score -= 1;
                document.getElementById(
                  players.player_list[i].name + '_score'
                ).innerText = players.player_list[i].score;
                break;
              }
            }
          }
        }
        guessArray = [];
        if (CPU_turn) {
          var comp_arr = computer_moves();
          is_set(comp_arr);
          comp_arr.length = 0;
        }
      }
    } else {
      grid_card.style.border = 'none';
      guessArray = guessArray.filter(function(value, index, arr) {
        value != card;
      });
    }
  });

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
  cardsInGrid.push(card);
}

/* Created by Jack Hanley
 Method that generates a hint for a player.  Tells the user a potential
 card to use */
function give_hint(arr) {
  var currentCombos = create_combos(arr, 3);
  var flag = false;
  var count = 0;
  var temp;
  if (set_present(currentCombos) == false) {
    window.alert('There may not be any sets to find here.');
  }
  while (flag == false && count < currentCombos.length) {
    temp = currentCombos[count];
    if (is_set(temp) == true) {
      flag = true;
    }
    count = count + 1;
  }
  window.alert(
    'Try using card with Color: ' +
      temp[0].color +
      ' | Shading: ' +
      temp[0].shading +
      ' | Shape: ' +
      temp[0].shape +
      ' | Count: ' +
      temp[0].number
  );
  return temp;
}

function Player(name, cp_flag) {
  this.name = name;
  this.score = 0;
  this.is_CPU = cp_flag;
}

window.onload = function() {
  var grid_obj = new Grid();
  var deck = new Deck();
  deckCards = deck.card_list;
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
    var sp_menu_view = document.getElementById('singleplayer_menu_view');
    var sp_game_view = document.getElementById('singleplayer_game_view');
    sp_menu_view.style.display = 'block';
    sp_game_view.style.display = 'none';
    var player_name = document.createElement('input');
    player_name.type = 'text';
    player_name.placeholder = 'Enter player name';
    sp_menu_view.appendChild(player_name);
    var start = document.createElement('button');
    start.type = 'button';
    start.innerHTML = 'Start';
    sp_menu_view.appendChild(start);
    start.addEventListener('click', function() {
      CPU_turn = true;
      if (player_name.value != '') {
        sp_menu_view.style.display = 'none';
        sp_game_view.style.display = 'block';
        if (document.getElementById('grid_container') != null) {
          grid_obj.removeGrid();
        }
        var player_div = document.createElement('div');
        player_div.id = 'player_div';
        var player = document.createElement('p');
        player.textContent = player_name.value + ': ';
        player.id = player_name.value;
        var player_score = document.createElement('p');
        player_score.id = player_name.value + '_score';
        player_score.textContent = player_name.score;
        player_div.appendChild(player);
        player_div.appendChild(player_score);
        sp_game_view.appendChild(player_div);
        var computer_div = document.createElement('div');
        computer_div.id = 'computer_div';
        var computer = document.createElement('p');
        computer.textContent = 'Computer: ';
        computer.id = 'computer';
        var computer_score = document.createElement('p');
        computer_score.id = 'computer_score';
        computer_score.textContent = '0';
        computer_div.appendChild(computer);
        computer_div.appendChild(computer_score);
        sp_game_view.appendChild(computer_div);
        player_list.player_list.push(new Player(player_name.value, false));
        grid_obj.addGrid(sp_game_view, deck.card_list, player_list);
        var hint = document.createElement('button');
        hint.type = 'button';
        hint.innerHTML = 'Give Hint';
        sp_game_view.appendChild(hint);
        hint.addEventListener('click', function() {
          give_hint(cardsInGrid);
        });
        var back = document.createElement('button');
        back.type = 'button';
        back.innerHTML = 'Back to Main Menu';
        sp_game_view.appendChild(back);
        back.addEventListener('click', function() {
          location.reload();
        });
      } else {
        window.alert('must fill in the argument');
      }
    });
  });

  /*starts the multiplayer view*/
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
        CPU_turn = false;
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
            score.id = inputs[i].value + '_score';
            score.textContent = '0';
            name.htmlFor = inputs[i].value;
            name.textContent = inputs[i].value + ': ';
            list.appendChild(new_input);
            list.appendChild(name);
            list.appendChild(score);
            player_list.player_list[i] = new Player(inputs[i].value);
          }
          grid_obj.addGrid(game, deck.card_list, player_list);
          game.appendChild(list);
          console.log(player_list);
        }
      });
  });

  /*starts the highscore*/
  buttons[3].addEventListener('click', function() {
    var list = document.getElementById('highscore_list');
    while (list.hasChildNodes()) {
      list.removeChild(list.lastChild);
    }
    if (player_list.highscore_list.length == 0) {
      var no_records = document.createElement('p');
      no_records.textContent = 'No records have been stored yet';
      list.appendChild(no_records);
    } else {
      var order_list = document.createElement('ol');
      for (i = 0; i < player_list.highscore_list.length; i++) {
        var item = document.createElement('li');
        item.textContent =
          player_list.highscore_list[i].name +
          ' : ' +
          player_list.highscore_list[i].score;
        order_list.appendChild(item);
      }
      list.appendChild(order_list);
    }
  });
  //grid_obj.addCard(deck.card_list.shift());
};
