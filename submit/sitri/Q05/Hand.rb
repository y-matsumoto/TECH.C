require './TrumpCard.rb'

class Hand
  attr :length, :hand
  
  # 初期化
  # @param 手札の枚数
  def initialize(length=0)
    @length = length
    @hand = Array.new(@length){ |i|
      TrumpCard.new(i)
    }
  end
  
  
end
