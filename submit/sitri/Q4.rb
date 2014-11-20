class Deck 
  #attr :tmp # 外からRのみ。attr_readerと同じ。
  attr_accessor :deck, :length #外からRW両方できる
  attr_writer :willShuffle #外からはWのみ
  
  # 初期化
  # @param length デッキの枚数
  def initialize(length)
    @length = length
    @deck = Array.new(@length){ |key| key+1 }
  end
  
  # デッキシャッフル
  def shuffle()
    @deck.shuffle!
  end
  
end

class Hand
  attr_accessor :length
  # 初期化
  # @param 手札の枚数
  def initialize(length=0)
    @length = length
  end
end

class Game
  @deck
  @hand
  @ansList
  
  # 初期化
  def initialize()
    @deck = Deck.new(9).shuffle
    @hand = @deck.shift(3)
    @ansList = Array.new()
  end
  
  # 答える
  def hitAndBlow(ans)
    unless validityAnswer?(ans) # 入力値チェック
      return
    end
    
    # 入力が大丈夫ならば、答え一覧にプッシュ
    @ansList.push( ans.split("") )
    p @ansList
  end
  
  # ansの文字列の妥当性
  def validityAnswer?(ans)
    # 3ケタの数字？
    unless /^\d{3}$/ =~ ans
      p "NOT 3 digit nums"
      return false
    end
    
    # 重複なし？
    ans_a = ans.split("")
    unless ans_a == ans_a.uniq
      p "NOT Unique"
      return false
    end
    
    # エラーがなければ
    return true
  end
  
  # 正解か？
  def collectAnswer?
    # もし、最後の回答が正解ならば、Trueで戻る。
    if @ansList.last(1) == @hand
      return true
    end
    # デフォルトは、Falseで戻る。
    return false
  end
  
end

#3つの異なる数字を選ぶ
game = Game.new
begin
  game.hitAndBlow(gets.strip)
  
end until game.collectAnswer?