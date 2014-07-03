class Trump

  # 初期化と同時にトランプを作る
  def initialize(suit,suji)
    @suit = suit
    @suji = suji
  end

  # トランプの絵柄を返す
  def get_suit
    @suit
  end

  def get_suji
    @suji
  end

  def set_suji(suji)
    @suji = suji
  end

  def set_suit(suit)
    @suit = suit
  end
end

class RoyalStraightFlash

  # カードリストを取得する
  def initialize(cardList)
    @cardList = cardList

    # 揃える絵柄
    @royalSuit = nil

    # カードの数値リスト
    @cardSujiList = nil

    # カードの絵柄リスト
    @cardSujiList = nil
  end

  # 1が一番大きくなるようにする
  def sort_one_top
    # 1を14にする
    for i in 0...5 do
      if (@cardList[i].get_suji == 1) then
        @cardList[i].set_suji(14)
      end
    end

    # 降順ソート
    tmp = [@cardList[0].get_suji,@cardList[1].get_suji,@cardList[2].get_suji,@cardList[3].get_suji,@cardList[4].get_suji].sort.reverse
    
    # 一時保存cardListソート後変数
    tmpCardList = Array.new(0)
    
    #cardListをソート
    for i in (0...5) do
      for j in (0...@cardList.size) do
        if (tmp[i] == @cardList[j].get_suji) then
          tmpCardList.push(@cardList[j])
          @cardList.delete_at(j)
          break
        end
      end
      
    end

    @cardList = tmpCardList

    # 14を1する
    for i in 0...5 do
      if (@cardList[i].get_suji == 14) then
        @cardList[i].set_suji(1)
      end
    end
    # ここまできたらすべてが正しく揃っているのでそれぞれ入れる
    @cardSujiList = [@cardList[0].get_suji,@cardList[1].get_suji,@cardList[2].get_suji,@cardList[3].get_suji,@cardList[4].get_suji]
    @cardSuitList = [@cardList[0].get_suit,@cardList[1].get_suit,@cardList[2].get_suit,@cardList[3].get_suit,@cardList[4].get_suit]
  end

  # 役チェック
  def check_royal
    # ロイヤルストレートフラッシュ
    # 最初のカードが1かつ絵柄が全部揃っていたらならば
    if(@cardSujiList[0] == 1 && @cardSuitList.uniq.size == 1) then
      flag = 1
      for i in (1...@cardSujiList.length) do
        if(@cardSujiList[i] == 14 - i) then
          flag += 1
        end
      end
      if(flag == 5) then
        return true
      end
    end
    return false
  end

  # 揃ってない番号を返す
  def get_incorrect
    royalSuji = [1,13,12,11,10]


    # 返す値

    # 変えるべき数値が入る
    changeList = Array.new(0)
    
    # 1,13,12,11,10があるか
    for i in (0...5) do
      if(@cardSujiList[0] == royalSuji[i]) then
        # あったらその数の絵柄を保存
        @royalSuit = @cardSuitList[0] 
      end
    end

    # ここまでで揃えるべき絵柄がわかったので次は変える必要のある数字を取り出す

    
    # １枚ずつ
    for i in (0...5) do

      # 正しい数があったかどうか調べるbool
      flag = false

      # 1,13,12,11,10じゃないかチェックする
      for j in (0...5) do

        # すでに基準になる絵柄があったら
        if (@royalSuit) then
          # 数値チェックリストがあり、数値があっていて、絵柄もあっていたら
          if(royalSuji[j] && @cardSujiList[i] == royalSuji[j] && @royalSuit == @cardSuitList[i]) then
            royalSuji[j] = nil
            flag = true
            break
          end

        # なかったら
        else
          # 数値チェックリストがあり数値があっていたら
          if(royalSuji[j] && @cardSujiList[i] == royalSuji[j]) then
            royalSuji[j] = nil
            flag = true
            break
          end
        end
      end
      # 正しくない数ならばfalseなので処理
      if (!flag) then
        changeList.push(@cardSujiList[i])
      end
    end
    return changeList
  end

  def get_royal_card
    if(@royalSuit) then
      return @cardList[0]
    end
    return nil
  end

  def set_card_list(cardList)
    @cardList = cardList
  end

  def view
    print "[#{@cardList[0].get_suji}][#{@cardList[1].get_suji}][#{@cardList[2].get_suji}][#{@cardList[3].get_suji}][#{@cardList[4].get_suji}]\n"
  end

end

# カードリスト収納
cardList = Array.new(5)

# トランプ収納
trumps = Array.new(4 * 13)

# 山札作ります

# カードの種類は4種類…
for i in (0...4) do

  # カードの数字は1~13まで…
  for j in (1..13) do
    trumps[((i*13)+j - 1)] = Trump.new(i,j)
  end

end

# シャッフル
trumps.shuffle!

# 5枚配る
for i in (0...5) do
  cardList[i] = trumps.pop
end

complete = false
royal = RoyalStraightFlash.new(cardList.clone)
turn = 0

ii = 0;

# ロイヤルストレートフラッシュができるまでループ
while (!complete) do
  turn += 1

  royal.sort_one_top

  # 揃っているか確認
  if (royal.check_royal) then
    complete = true
  #揃っていない場合
  else
    # 変えるべき数値を取る
    changeNum = royal.get_incorrect
    # 基準のカードのデータを取る
    royalCard = royal.get_royal_card
    
    # カードを変更する場所を保存
    change = Array.new(0)

    for i in (0...5) do
      # 基準のカードがあったら
      if(royalCard) then
        # 変える対象を抜き出し
        for j in (0...changeNum.size) do
          # 基準のカードじゃないかチェック
          if(royalCard.get_suji == cardList[i].get_suji && 
             royalCard.get_suit == cardList[i].get_suit) then
          else
            # 変える対象に出会ったら
            if(changeNum[j] == cardList[i].get_suji)then
              # 番号を保存
              changeNum[j] = 0
              change.push(i)
              break
            end
          end
        end
      # 基準のカードが無かったら
      else
        # 変える対象を抜き出し
        for j in (0...changeNum.size) do
          # 変える対象に出会ったら
          if(changeNum[j] == cardList[i].get_suji)then
            # 番号を保存
            changeNum[j] = 0
            change.push(i)
            break
          end
        end
      end
    end
    # ここまで来たら変えるべき場所がわかっている
    for i in (0...change.size) do
      # カードを戻して
      trumps.unshift(cardList[change[i]])
      #新しくカードを引く
      cardList[change[i]] = trumps.pop
    end
    # カードを送る
    royal.set_card_list(cardList.clone)
  end
end

royal.view
puts "ロイヤルストレート完成までに#{turn}回かかりました"