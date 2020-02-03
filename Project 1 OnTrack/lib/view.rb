# Created by Von M 1/24/2020
require 'tty-table'

# A table representation of the dealt cards
class View 
  attr_accessor :cardList

  def initialize(cardList) 
    @cardList = cardList
  end

  #updates the cardList array
  def update(newCardList) 
    @cardList = newCardList
  end

  #displays the current cardList to the terminal 
  def render 
    table = TTY::Table.new header: ['Card #','Color', 'Shape', 'Number', 'Shading']
    index = 1
    cardList.each do |card|
      table << [index.to_s, num_to_color(card.color), num_to_shape(card.shape), (card.number + 1).to_s, num_to_shading(card.shading)]
      index += 1
    end

    finalTable = table.render :unicode do |renderer| 
      renderer.alignments = [:center, :left, :left, :left, :left]
      renderer.border.separator = :each_row
    end

    puts finalTable
  end

  private
  #Converts a number to their respected color
  def num_to_color(number) 
    case number
    when 0
      "Red"
    when 1
      "Green"
    when 2
      "Purple"
    end

  end

  #Converts a number to their respected shape
  def num_to_shape(number) 
    case number
    when 0
      "Squiggle"
    when 1
      "Oval"
    when 2
      "Diamond"
    end

  end

  #Converts a number to their respected Shading
  def num_to_shading(number) 
    case number
    when 0
      "Solid"
    when 1
      "Open"
    when 2
      "Striped"
    end

  end
end
