class Game

end

class Deck 
  #attr :tmp # 外からRのみ。attr_readerと同じ。
  attr_accessor :deck, :deckLength #外からRW両方できる
  attr_writer :willShuffle #外からはWのみ
  
  def initialize(length, willShuffle=false)
    @length = deckLength
    @deck = Array.new(@length){ |key| key+1 }
    @willShuffle = willShuffle
    if true==@willShuffle then
      @deck.shuffle!
    end
    
  end
  
end

class Hand
  attr_accessor :length
  def initialize(length=0)
    @length = length
  end
end


#3つの異なる数字を選ぶ
tmpDeck = Deck.new(10, true)
hand = tmpDeck.deck.shift(3)

