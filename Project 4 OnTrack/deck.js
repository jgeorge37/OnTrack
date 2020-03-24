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