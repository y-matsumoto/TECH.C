class Deck << Array
  class << self
    def initialize(length = 9)
      self
    end
  end
  
end

class Hand

  @cardList # array
  
  def initialize() # when new, called
    @cardList = Array.new(3){-1}
  
  end
  def getCardList()
    return @cardList
  end
  def setCardList()
    return false
  end

end

def game()

end

hand01 = Hand.new()
p hand01.getCardList()

# init game

# game start
# build cardset

# while true
  # shoot numbers

  # if complete, game end

#game end