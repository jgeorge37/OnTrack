// Created by Snigdha Tiwari 3/17/20
// computer functionality
function computer_moves(){
    var prob_of_win = Math.random();
    var cp_array = [];
    var cp_score = Number(document.getElementById('computer_score').textContent);
    // Makes it so that the computer is not winning most of the time
    if(prob_of_win > 0.75){
        cp_array = give_hint(cardsInGrid);
    }else{
        cp_array[0] = cardsInGrid[Math.floor(Math.random()*10)];
        cp_array[1] = cardsInGrid[Math.floor(Math.random()*10)];
        cp_array[2] = cardsInGrid[Math.floor(Math.random()*10)];
    }
    // check if the set the computer chose is valid or not
    // update score
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


