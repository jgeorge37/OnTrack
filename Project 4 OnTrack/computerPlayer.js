// Created by Snigdha Tiwari 3/17/20

// Return array of 3 cards the computer choose.
function computer_moves(correct_set, table_size){
    var card_array = new Array(table_size-1)
    //var choice = new Array(3)
    var choices_array = new Array(false,true,false)

    shuffle(choices_array)
    var choice = choices_array.shift()

    if (choice && (!Array.isArray(correct_set) || !correct_set.length)) {
        alert("computer chose: " + correct_set[1] + ", " +  correct_set[2] + " ," + correct_set[3])
    } else {
        shuffle(card_array)
        var card1 = card_array.shift()

        shuffle(card_array)
        var card2 = card_array.shift()

        shuffle(card_array)
        var card3 = card_array.shift()

        alert("Computer chose: " + card1 + " , " + card2 + " , " + card3)

    }


}

/**
 * Shuffles array in place.
 * @param {Array} a items An array containing the items.
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
