class Deck 
  attr_accessor :deck, :length
    
  # 初期化
  def initialize(jokerNum = 2)
    @deck = Array.new(52+jokerNum){|i| i }
  end
  
  # デッキシャッフル
  def shuffle()
    @deck.shuffle!
  end
  
end
