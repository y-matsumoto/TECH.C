class Deck 
  #attr :tmp # 外からRのみ。attr_readerと同じ。
  attr_accessor :deck, :length #外からRW両方できる
  attr_writer :willShuffle #外からはWのみ
  
  def initialize(length)
    @length = length
    @deck = Array.new(@length){ |key| key+1 }
  end
  
  def shuffle()
    @deck.shuffle!
  end
  
end

class Hand
  attr_accessor :length
  def initialize(length=0)
    @length = length
  end
end

class Game
  @deck
  attr_accessor :hand
  
  def initialize()
    @deck = Deck.new(9).shuffle
    @hand = @deck.shift(3)
  end
  
  def answer(ans)
    unless 3 == ans.length then
      p "your answer's length is required 3."
      p "retry input"
      return
    end
  end
  
  def collectAnswer?
    return true
    #return false
  end
  
  
end

#3つの異なる数字を選ぶ
game = Game.new
begin

end until game.collectAnswer?