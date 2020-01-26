# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - added attributes
# Edited by Jing George - 1/26/2020 - initializes with name and score of 0
#
# Player object with name and score
class Player
  attr_accessor :name
  attr_accessor :score

  def initialize(name)
    @name = name
    @score = 0
  end

end
