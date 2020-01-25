# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - added attributes
# Edited by Von Mbah - 1/22/2020 - fixed spelling mistake iniaitlize -> initialize
#
# Card object with Color, Shape, Number, and Shading Attributes
class Card
  attr_accessor :color
  attr_accessor :shape
  attr_accessor :number
  attr_accessor :shading

  def initialize(color,shape,number,shading)
    @color = color
    @shape = shape
    @number = number
    @shading = shading
  end
end