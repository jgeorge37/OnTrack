# Created by Jing George - 1/26/2020
# Edited by Snigdha Tiwari - 2/3/2020 - Added a def to create computer name
# Edited by Snigdha Tiwari - 2/4/2020 - Added documentation and methods
#
# Class to manage scores of multiple players

require_relative 'player'
require 'tty-table'

# Object that represents a group of players
class PlayerGroup
  attr_accessor :player_list

  # Created by Jing George - 1/26/20
  # Initialize a PlayerGroup
  # @return [Self]
  def initialize
  #Initialize list of players
    @player_list = []
    @highscore_list = []
  end

  # Created by Jing George - 1/26/20
  #
  # Creates player objects with player names at game start
  def add_players
    # Ask for number of players
    puts("Enter the number of players.")
    playerCount = Integer(gets.chomp) rescue false
    while !playerCount || playerCount < 1 do
      puts("Enter the number of players as an integer.")
      playerCount = Integer(gets.chomp) rescue false
    end

    # List of names of players to ensure no duplicates
    usedNames = []

    # Get the names of the players
    while @player_list.size < playerCount
      # Ask for player identifier
      puts("Enter a unique player name.")
      name = gets.chomp

      # Check if player name is already taken
      if usedNames.include?(name)
        puts("The name \"#{name}\" is already taken!")
        # Go back to ask for a unique name again
        next
      end

      print "\e[H\e[2J"
      # Add new Player object to player list
      @player_list.append(Player.new(name))
      # Add name to list of used names
      usedNames.append(name)
      # Confirm player was added
      puts("#{name} has been added to the game.")

    end

    # Confirm that players were added to game
    puts("#{playerCount} players added to game.")
  end

  # Created by Sngidha Tiwari - 2/3/20
  #
  # Add player for the computer and user itself to play against the computer
  #
  #

  def add_computer
    puts("Enter a unique player name.")
    name = gets.chomp
    @player_list.append(Player.new("Computer"))
    @player_list.append(Player.new(name))

  end

  # Created by Jing Geroge - 1/26/20
  #
  # Update score based on player name and change param; negative values for
  # deduction, positive values for addition
  #
  # @param [String] name
  # @param [Integer] change
  def update_score(name, change)
    # Player gets 3 tries to input name correctly
    for i in 1..3
      @player_list.each do |player| 

        # If the player object is found, adjust score
        if name == player.name
          player.score = player.score + change
          puts("#{name}\'s score is now #{player.score}.")
          return
        end

      end

      # Prompt user to try entering name again
      puts("\"#{name}\" is not a player name in use.")
      puts("Please try entering your name again.")
      name = gets.chomp
    end

    # Player is out of chances to input name correctly; cancel score update.
    puts("Out of tries to enter a valid player name. No score change.")
  end

  # Created by Jing George - 1/26/20
  #
  # Prints the names of the players with the highest score.
  def print_game_result
    # Winners stored in list in case of tie
    winners = []
    highestScore = @player_list[0].score

    # Determine who has the highest score
    @player_list.each do |player|

      # Highest score thus far is matched
      if highestScore == player.score
        winners.append(player.name)
      # Highest score is beaten
      elsif highestScore < player.score
        # Empty list of winners
        winners.clear
        # Add the current winner's name to the winner list
        winners.append(player.name)
        # Update current high score
        highestScore = player.score
      end

    end

    # Print the winner(s)
    if winners.size > 1
      puts("It's a tie! The winners:")
    else
      puts("Winner:")
    end

    winners.each { |winner| puts(winner) }
  end

  # Displays the top players high score
  def list_top_players
    if @highscore_list.empty?
      puts "No available data."
    else
      table = TTY::Table.new header: ['Name', 'Score']
      @highscore_list.each do |player|
          table << [player.name, player.score]
      end

      finalTable = table.render :unicode do |renderer|
          renderer.alignments = [:left, :center]
          renderer.border.separator = :each_row
      end

      puts "Sets Current Highscore"
      puts finalTable
    end
    
  end

  # Updates the top players high score
  # @param [Array] player_list
  def update_highscore!(player_list)
    player_list.each do |player|
      if @highscore_list.empty? 
        @highscore_list[0] = player
      elsif @highscore_list.size < 5
        if @highscore_list.size == 1
          if @highscore_list[0].score >= player.score
              @highscore_list[@highscore_list.size] = player
          else
            @highscore_list.unshift player
          end

        elsif @highscore_list[@highscore_list.size - 1].score >= player.score
          @highscore_list[@highscore_list.size] = player
        else
          for i in 0..@highscore_list.size-2
            if @highscore_list[@highscore_list.size - i - 1].score <= player.score &&
               @highscore_list[@highscore_list.size - i - 2].score >= player.score

              @highscore_list.insert @highscore_list.size - i - 1, player
            end

          end

        end

      elsif player.score > @highscore_list[4].score 
          for i in 0..3 do
            if @highscore_list[4 - i].score <= player.score && 
              @highscore_list[4 - i - 1].score >= player.score 

              @highscore_list.insert 4 - i - 1, player
              @highscore_list.pop
              break
            end
          
        end

      end

    end

  end
end
