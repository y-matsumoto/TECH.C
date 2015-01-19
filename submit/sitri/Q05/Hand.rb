class Hand
  include Enumerable
  attr_accessor :length, :hand
  # 初期化
  # @param 手札の枚数
  def initialize(length=0)
    @length = length
    @hand = Array.new(@length){ |i| i }
  end
end
