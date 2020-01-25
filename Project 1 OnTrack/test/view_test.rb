require_relative '../lib/view'
require_relative '../lib/card'

singleCard = [Card.new('red', 'square', '10', 'none')]
singleView = View.new(singleCard)
singleView.render
singleCard = [Card.new('blue', 'triangle', '5', 'small')]
singleView.update singleCard
singleView.render