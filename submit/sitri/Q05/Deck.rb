require './TrumpCard.rb'

class Deck 
  attr :deck, :length
    
  # 初期化
  def initialize(jokerNum = 1)
    @deck = Array.new(52+jokerNum){|i|
      TrumpCard.new(i)
    }
  end
  
  # デッキシャッフル
  def shuffle()
    @deck.shuffle!
  end
  
end
