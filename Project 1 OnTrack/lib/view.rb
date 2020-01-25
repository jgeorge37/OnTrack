# Created by Von M 1/24/2020
require 'tty-table'
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
        cardList.each do |card|
            index = 1
            table << [index.to_s, card.color.to_s, card.shape.to_s, card.number.to_s, card.shading.to_s]
            index += 1
        end
        puts table.render :unicode, alignments: [:center, :left, :left, :left, :left]
    end

end