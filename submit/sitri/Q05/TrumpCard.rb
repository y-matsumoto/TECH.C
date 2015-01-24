class TrumpCard
  
  #　カードの種類 :@cardId
  # n/13して、 0: スペード, 1: クローバ, 2: ダイヤ, 3: ハート, 4: ジョーカ
  # n%13して、 +1したのが、カードの数値。ジョーカは一律で0。
  # 0 - 
  attr :id, :rank, :suit
  
  def initialize( id = rand(53) )
    @id = id
    
    # suit ジョーカーが14枚以上の可能性を考慮して、条件分岐してる。
    if @id/13 > 4 then
      @suit = 4
    else 
      @suit = @id/13
    end
    
    # rank 番号。ジョーカーは連番
    if @suit == 4 then 
      @rank = 0
    else
      @rank = 1 + (@id % 13)
    end
  end
  
end
