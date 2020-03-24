

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
  is_set = is_set && attribute_check(card1.shading, card2.shading, card3.shading);


  // Reset card css border
  var allCards = document.getElementsByClassName('grid_card');
  for (var i = 0; i < allCards.length; i++) {
    allCards[i].style.border = "";
  }
  if (is_set == true) {
    window.alert("yay");
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