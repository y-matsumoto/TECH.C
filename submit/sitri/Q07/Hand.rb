require './TrumpCard.rb'

class Hand
  attr :length, :cards
  
  # 初期化
  # @param 手札の枚数
  def initialize(length=0)
    @length = length
    @cards = Array.new(@length){ |i|
      TrumpCard.new(i)
    }
  end
  
  def shuffle!
    @cards.shuffle!
  end
  
  def sort!
    @cards.sort! { |a, b|
      a.id <=> b.id
    }
  end
  
  def each
    yield @cards
  end
  
end
