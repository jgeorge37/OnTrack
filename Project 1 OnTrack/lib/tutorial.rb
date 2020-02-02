# Created by Jack Thompson - 2/2/2020

require "tty-prompt"
require_relative 'card'
require_relative 'ascii'

class Tutorial
  def display
    print "\e[H\e[2J"
    prompt = TTY::Prompt.new
    display = Ascii.new
    print("Welcome to the Game of Set! Press <Enter> to continue")
    gets
    print("In this game, you need to find the three cards on the table that make up a set")
    gets
    print("Each card has four attributes: color, number, shape, and shading")
    gets
    puts("For example. Take a look at this card")
    for line in 1..8 do
      display.printByLine(Card.new(0,2,1,2), line)
      puts
    end
    print("This card is red coloring, has a number of 1, a shape of hexagon, and vertical shading")
    gets
    print("Three cards make up a set when, for each attribute, they all have different values or the same values")
    gets
    puts

    cardDisplay = []
    cardDisplay.append(Card.new(0,2,1,2))
    cardDisplay.append(Card.new(0,1,0,2))
    cardDisplay.append(Card.new(0,0,2,2))
    for line in 1..8 do
      for item in 0..2 do
        display.printByLine(cardDisplay[item], line)
        print("   ")
      end
      puts
    end

    print("These three cards make up a set")
    gets
    print("All three cards have the same color: red")
    gets
    print("All three cards have different shapes: hexagon, triangle, and square")
    gets
    print("All three cards have different numbers: 1, 0, and 2")
    gets
    print("All three cards have the same shading: vertical")
    gets
    puts
    puts

    cardDisplay = []
    cardDisplay.append(Card.new(0,2,1,2))
    cardDisplay.append(Card.new(0,1,0,2))
    cardDisplay.append(Card.new(1,0,2,2))
    for line in 1..8 do
      for item in 0..2 do
        display.printByLine(cardDisplay[item], line)
        print("   ")
      end
      puts
    end

    print("These three cards do not make up a set")
    gets
    print("This is because two of the cards have the color red while only one has a different color (blue)")
    gets
    print("In the case where there is no set currently on the table, select the NoSet option to add three more cards")
    gets
    print("Each correctly identified set adds one point to the player's score")
    gets
    print("Each incorrect guess at a set takes one point away from the player's score")
    gets
    print("The goal of the game is to have the highest score once the deck completely runs out of cards")
    gets
  end
end