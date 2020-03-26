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
    var result = false;
    result = attr1 == attr2 && attr1 == attr3;
    result = result || (attr1 != attr2 && attr1 != attr3 && attr2 != attr3);
    return result;
}
/* function that checks if three given cards are a set */
function is_set(array) {
    var card1 = array[0];
    var card2 = array[1];
    var card3 = array[2];

    var is_set;
    // Call attribute_check method on all 4 attributes for each card.
    is_set = attribute_check(card1.color, card2.color, card3.color);
    is_set = is_set && attribute_check(card1.shape, card2.shape, card3.shape);
    is_set = is_set && attribute_check(card1.number, card2.number, card3.number);
    is_set =
        is_set && attribute_check(card1.shading, card2.shading, card3.shading);

    // Reset card css border
    var allCards = document.getElementsByClassName('grid_card');
    for (var i = 0; i < allCards.length; i++) {
        allCards[i].style.border = '';
    }
    return is_set;
}
/* funtion to create all combos possible
   Adapted from: https://www.w3resource.com/javascript-exercises/javascript-func
   tion-exercise-21.php
*/
function create_combos(arra, arra_size) {
    var result_set = [];
    var result;

    for (var x = 0; x < Math.pow(2, arra.length); x++) {
        result = [];
        i = arra.length - 1;
        do {
            if ((x & (1 << i)) !== 0) {
                result.push(arra[i]);
            }
        } while (i--);

        if (result.length == arra_size) {
            result_set.push(result);
        }
    }

    return result_set;
}
/* function that checks if a set is present in the cards on table */
function set_present(arr) {
    var setPresent = false;
    var count = 0;
    while (setPresent == false && count < arr.length) {
        temp = arr[count];
        if (is_set(temp) == true) {
            setPresent = true;
        }
        count = count + 1;
    }
    return setPresent;
}

// Created by Snigdha Tiwari 3/17/20

// Return array of 3 cards the computer choose.
function computers_cards(correct_set) {
    var card_array = new Array(3);

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

/* adds a card to the grid. */
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
                        for (i = 0; i < inputs.length; i++) {
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
                        for (i = 0; i < inputs.length; i++) {
                            if (inputs[i].checked) {
                                console.log(players.player_list[i]);
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
                    if (is_set(comp_arr)) {
                        grid_obj.removeCard(comp_arr, deckCards);
                    }
                    comp_arr.length = 0;
                }
            }
        } else {
            grid_card.style.border = 'none';
            for (i = 0; i < guessArray.length; i++) {
                if (guessArray[i] === card) { guessArray.splice(i, 1) };
            }
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

function give_hint(arr) {
    var currentCombos = create_combos(arr, 3);
    var flag = false;
    var count = 0;
    var temp;
    while (flag == false && count < currentCombos.length) {
        temp = currentCombos[count];
        if (is_set(temp) == true) {
            flag = true;
        }
        count = count + 1;
    }
    if (set_present(currentCombos) == false) {
        window.alert('There may not be any sets to find here.');
    } else {
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
    }

    return temp;
}

// creates an array of possible cards, size 3, for the computer
function create_combos_comp(arr) {
    var currentCombos = create_combos(arr, 3);
    var flag = false;
    var count = 0;
    var cpu_arr = [];
    while (flag == false && count < currentCombos.length) {

        cpu_arr = currentCombos[count];

        if (is_set(cpu_arr) == true) {
            flag = true;
        }
        count = count + 1;
    }
    return cpu_arr;
}