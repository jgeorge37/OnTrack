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

        // No more remaining cards in grid or deck or no more combos
        var currentCombos = create_combos(cardsInGrid, 3);

        if ((grid.childNodes.length == 0 && card_list.length == 0) || (grid.childNodes.length < 12 && !set_present(currentCombos))) {
            if (document.getElementById('multiplayer_view').style.display != 'none') {
                var inputs = document.getElementById('player_list').getElementsByTagName('input');
                var highscore = 0;
                var highscore_player;
                for (i = 0; i < inputs.length; i++) {
                    var score = document.getElementById(inputs[i].value + '_score').innerHTML;
                    if (score > highscore) {
                        highscore = score;
                        highscore_player = inputs[i].value;
                    }
                }
                window.alert('There are no more cards. The winner is ' + highscore_player + ' with ' + highscore + ' points!');
            } else {
                var playerid = document.getElementById('player_div').getElementsByTagName('p')[0].id;
                var playerscore = document.getElementById(playerid + '_score').textContent;
                var computerscore = document.getElementById('computer_score').textContent;
                console.log(playerscore);
                if (playerscore > computerscore) {
                    window.alert('Congrats! You beat the computer with ' + playerscore + ' points!');
                } else {
                    window.alert('The computer beat you with ' + computerscore + ' points');
                }
            }
            location.reload();
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
