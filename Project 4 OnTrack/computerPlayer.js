// Created by Snigdha Tiwari 3/17/20

function computer_moves(){
    var prob_of_win = Math.random();
    var cp_array = [];
    var cp_score = Number(document.getElementById('computer_score').textContent);
    if(prob_of_win > 0.75){
        cp_array = give_hint(cardsInGrid);
    }else{
        cp_array[0] = cardsInGrid[Math.floor(Math.random()*10)];
        cp_array[1] = cardsInGrid[Math.floor(Math.random()*10)];
        cp_array[2] = cardsInGrid[Math.floor(Math.random()*10)];
    }
    if(is_set(cp_array)){
        cp_score += 3;
        window.alert("Computer got a set")
    }else{
        cp_score -= 1;
        window.alert("Computer did not get a set")
    }
    document.getElementById('computer_score').textContent = cp_score;



    return cp_array;
}


