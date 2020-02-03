# Created by Jack Thompson - 2/2/2020
require_relative 'card'
require 'paint'

# A visual representation of the cards with their shape, color, shading and numbering 
class Ascii
  def shading(card, amount, color)
    amount.times do
      case card.shading
      when 0
        print(" ")
      when 1
        print(Paint["-", color])
      when 2
        print(Paint["|", color])
      end

    end

  end

  def print_by_line(card, line)
    case card.color
    when 0
      color = :red
    when 1
      color = :blue
    when 2
      color = :green
    else

    end
    
    case card.shape
    when 0
      case line
      when 1, 8
        print(Paint["_________________", color])
      when 2, 3, 4, 6, 7
        print(Paint["|", color])
        shading(card, 15, color)
        print(Paint["|", color])
      when 5
        print(Paint["|       #{card.number}       |", color])
      else

      end

    when 1
      case line
      when 1
        print(Paint["       /\\        ", color])
      when 2
        print(Paint["      /", color])
        shading(card, 2, color)
        print(Paint["\\       ", color])
      when 3
        print(Paint["     /", color])
        shading(card, 4, color)
        print(Paint["\\      ", color])
      when 4
        print(Paint["    /", color])
        shading(card, 6, color)
        print(Paint["\\     ", color])
      when 5
        print(Paint["   /", color])
        shading(card, 8, color)
        print(Paint["\\    ", color])
      when 6
        print(Paint["  /    #{card.number}     \\   ", color])
      when 7
        print(Paint[" /", color])
        shading(card, 12, color)
        print(Paint["\\  ", color])
      when 8
        print(Paint["/______________\\ ", color])
      else

      end

    when 2
      case line
      when 1
        print(Paint["   __________    ", color])
      when 2
        print(Paint["  /", color])
        shading(card, 10, color)
        print(Paint["\\   ", color])
      when 3
        print(Paint[" /", color])
        shading(card, 12, color)
        print(Paint["\\  ", color])
      when 4
        print(Paint["/", color])
        shading(card, 14, color)
        print(Paint["\\ ", color])
      when 5
        print(Paint["|       #{card.number}      | ", color])
      when 6
        print(Paint["\\", color])
        shading(card, 14, color)
        print(Paint["/ ", color])
      when 7
        print(Paint[" \\", color])
        shading(card, 12, color)
        print(Paint["/  ", color])
      when 8
        print(Paint["  \\__________/   ", color])
      end
    else

    end

  end
end
