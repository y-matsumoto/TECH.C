class Deck 
  #attr :tmp # 外からRのみ。attr_readerと同じ。
  attr_accessor :deck, :length #外からRW両方できる
  
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
  attr_reader :fin
  
  # 初期化
  def initialize()
    @deck = Deck.new(9).shuffle
    @hand = @deck.shift(3)
    @ansList = Array.new()
    @fin = false
  end
  
  # 答える
  def answer(ans)
    if ans == "0" then
      @fin = true
      return 
    end
    unless validityAnswer?(ans) # 入力値チェック
      return
    end
    
    # (入力が大丈夫ならば、)
    # ansを配列にして
    ans = ans.split("").collect{|c| c.to_i}
    #答え一覧にプッシュ
    @ansList.push( ans )
    #p ans #確認用の表示だけど、残しておいても良き
    
    hit = 0;
    blow = 0;
    no = 0;13
    ans.each_index { |i|
      case @hand.index( ans[i] )
      when i
        hit += 1
      when nil
        no += 1
      else
        blow += 1
      end
    }
    
    p "[#{@ansList.length}] hit: #{hit}, blow: #{blow}"
    if hit == 3 then 
      @fin = true
    end
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
end

#3つの異なる数字を選ぶ
game = Game.new
begin
  game.answer(gets.strip)
end until game.fin