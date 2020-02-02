# Created by Jing George - 1/26/2020
#
# Class to manage scores of multiple players

require_relative 'player'

class PlayerGroup
	attr_accessor :playerList

	# Created by Jing George - 1/26/20
	def initialize
		#Initialize list of players
		@playerList = []
	end

	# Created by Jing George - 1/26/20
	#
	# Creates player objects with player names at game start
	def addPlayers
		# Ask for number of players
		puts("Enter the number of players.")
		playerCount = Integer(gets.chomp) rescue false
		while !playerCount do
			puts("Enter the number of players as an integer.")
			playerCount = Integer(gets.chomp) rescue false
		end

		# List of names of players to ensure no duplicates
		usedNames = []

		# Get the names of the players
		while @playerList.length < playerCount do
			# Ask for player identifier
			puts("Enter a unique player name.")
			name = gets.chomp

			# Check if player name is already taken
			if usedNames.include?(name)
				puts("The name \"#{name}\" is already taken!")
				# Go back to ask for a unique name again
				next
			end

			# Add new Player object to player list
			@playerList.append(Player.new(name))
			# Add name to list of used names
			usedNames.append(name)
			# Confirm player was added
			puts("#{name} has been added to the game.")

		end

		# Confirm that players were added to game
		puts("#{playerCount} players added to game.")
	end

	# Created by Jing Geroge - 1/26/20
	#
	# Update score based on player name and change param; negative values for
	# deduction, positive values for addition
	def updateScore(name, change)
		# Player gets 3 tries to input name correctly
		for i in 1..3
			@playerList.each do |player|

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
	def printGameResult
		# Winners stored in list in case of tie
		winners = []
		highestScore = @playerList[0].score

		# Determine who has the highest score
		@playerList.each do |player|

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
		if winners.length > 1
			puts("It's a tie! The winners:")
		else
			puts("Winner:")
		end
		winners.each { |winner| puts(winner)}
	end

end
