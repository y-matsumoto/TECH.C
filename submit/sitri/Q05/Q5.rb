require './TrumpCard.rb'
require './Deck.rb'
require './Hand.rb'

class Play
  attr :play, :result
  def initialize(game)
    @play << game
  end
end

class Game 
  attr :game
  attr :dealer, :player
end

module PokerHand
  
end