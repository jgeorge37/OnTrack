// Created by Snigdha Tiwari 3/17/20

function computer_moves() {
  var prob_of_win = Math.random();
  var cp_array = [];
  var cp_score = Number(document.getElementById('computer_score').textContent);
  if (prob_of_win > 0.75) {
    cp_array = give_hint(cardsInGrid);
  } else {
    cp_array[0] = cardsInGrid[Math.floor(Math.random() * 10)];
    cp_array[1] = cardsInGrid[Math.floor(Math.random() * 10)];
    cp_array[2] = cardsInGrid[Math.floor(Math.random() * 10)];
  }
  if (is_set(cp_array)) {
    cp_score += 3;
    window.alert('Computer got a set');
  } else {
    cp_score -= 1;
    window.alert('Computer did not get a set');
  }
  document.getElementById('computer_score').textContent = cp_score;

  return cp_array;
}

/* Return array of 3 cards the computer choose.
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


}*/

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
