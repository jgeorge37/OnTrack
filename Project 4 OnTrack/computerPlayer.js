// Created by Snigdha Tiwari 3/17/20
// computer player functionality
function computer_moves(){
    var prob_of_win = Math.random();
    var cp_array = [];
    var cp_score = Number(document.getElementById('computer_score').textContent);
    // makes the chance of the computer finding a set to 25%
    if(prob_of_win > 0.75){
        cp_array = give_hint(cardsInGrid);
    }else{
        // if computer chance is less than 0.75 then just pick 3 random cards from the current cards
        cp_array[0] = cardsInGrid[Math.floor(Math.random()*10)];
        cp_array[1] = cardsInGrid[Math.floor(Math.random()*10)];
        cp_array[2] = cardsInGrid[Math.floor(Math.random()*10)];
    }
    // checks to see if the current array contains a set
    // updates score
    if(is_set(cp_array)){
        cp_score = cp_score+1;
        window.alert("Computer got a set")
    }else{
        cp_score=cp_score-1;
        window.alert("Computer did not get a set")
    }
    document.getElementById('computer_score').textContent = cp_score;



    return cp_array;
}


