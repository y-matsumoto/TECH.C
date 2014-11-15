# 定数
ERROR = -1

MAX_HAND  = 5
MAX_CARD  = 13
CARD_TYPE = 4

HIGH_CARD  = 10
ONE_PAIR   = 11
TWO_PAIR   = 12
THREE_OF_A_KIND = 13
STRAIGHT   = 14
FLUSH      = 15
FULL_HOUSE = 16
FOUR_OF_A_KIND = 17
STRAIGHT_FLASH = 18
ROYAL_STRAIGHT_FLASH = 19

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

end

class Bunch

  # 初期化
  def initialize()
    @cardSujiList = Array.new(5)
  end

  def sort_card
    sort_suji
  
    # 一時的にcardListを格納しておく
    cardListTemp = Array.new() 
    for i in (0...@cardList.length) do
      for j in (0...@cardList.length) do
        if(@cardSujiList[i] == @cardList[j].get_suji) then
          cardListTemp.push(@cardList[j])
          @cardList.delete_at(j)
          break
        end
      end
    end
    # 上書き
    @cardList = cardListTemp

    # これでようやく強い順に並んだ
  end

  # カードを強い順に並べる
  def sort_suji
    # 数字を降順にソートして取り出す
    @cardSujiList = [@cardList[0].get_suji,@cardList[1].get_suji,@cardList[2].get_suji,@cardList[3].get_suji,@cardList[4].get_suji].sort.reverse
    # 1の数
    oneCount = 0

    # 1があるか調べる
    for i in (0...@cardList.length) do
      if(@cardSujiList[i] == 1) then
        oneCount += 1
      end
    end

    # 1があったら1を前に出す
    if(oneCount != 0) then
      for i in (1..oneCount) do
        # 消す
        @cardSujiList.delete_at(@cardList.length - 1)
        # 付け足す
        @cardSujiList.unshift(1)
      end
    end
  end

  def view_myTrumps

    for i in (0...5) do
      print "#{i + 1} : "
      if(@cardList[i].get_suit == 0) then
        print "[スペードの"
      elsif(@cardList[i].get_suit == 1) then
        print "[クローバーの"
      elsif(@cardList[i].get_suit == 2) then
        print "[ハートの"
      elsif(@cardList[i].get_suit == 3) then
        print "[ダイアの"
      end

      print "{#{@cardList[i].get_suji}}]\n"
    end
  end

  def remove_card(removeArray)
    for i in (0...removeArray.length) do
      # 実際の位置は-1なので-1する(配列は0から始まる)
      # ただし消すごとに配列が少なくなるのでそれも考慮
      @cardList.delete_at((removeArray[i].to_i - 1)-(MAX_HAND - @cardList.length))
    end
  end

  def add_card(card)
    @cardList.push(card)
  end

  def set_card_list(cardList)
    @cardList = cardList
  end

  def get_card_list
    @cardList
  end

  def get_card_suji_list
    @cardSujiList
  end

  def get_card_suit_list
    cardSuitList = Array.new()
    for i in (0...@cardList.length) do
      cardSuitList.push(@cardList[i].get_suit)
    end
    cardSuitList.sort
  end

end

# ペア判定する人
class Diller
  
  def initialize
   @cardSujiList = Array.new(5)
   @cardSuitList = Array.new(5)
  end

  def set_card_suji_list(cardSujiList)
    @cardSujiList = cardSujiList
  end

  def set_card_suit_list(cardSuitList)
    @cardSuitList = cardSuitList
  end

  # 役をチェック
  def check_pair
    # 細かいところまで
    pair = {"pair"=>-1,"high"=>"","kicker"=>""}
    # デバック用
    #@cardSujiList = [1,13,13,3,2]
    #@cardSuitList = [1,0,0,0,0]

    # 全部同じ数字の場合はエラー(ファイブカードだけど) 
    if(@cardSujiList.uniq.size == 1) then
      return ERROR
    end

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
        pair['pair'] = ROYAL_STRAIGHT_FLASH 
        return pair
      end
    end

    # カードの強い順関係があり複数比較する役に使う
    cardSujiListTemp  = @cardSujiList

    # カードの強い順関係ない役に使う
    @cardSujiList = @cardSujiList.sort.reverse

    # ストレートフラッシュ
    # 絵柄が全部揃っているか
    if(@cardSuitList.uniq.size == 1) then
      flag = 1
      firstNum = @cardSujiList[0]
      for i in (1...@cardSujiList.length) do
        if(@cardSujiList[i] == firstNum - i)
          flag += 1
        end
      end
      if(flag == 5) then
        pair['high'] = @cardSujiList[0]
        pair['pair'] = STRAIGHT_FLASH 
        return pair
      end
    end

    # フォーカード
    # は2種類のはずなのでそれでわける
    if(@cardSujiList.uniq.size == 2)
      # その二種類のカードの個数を取り出す
      for i in 0..1 do
        if(@cardSujiList.count(@cardSujiList.uniq[i]) == 4)
          pair['high'] = @cardSujiList.uniq[i]
          cardSujiListTemp.delete(pair['high'])
          pair['kicker'] = cardSujiListTemp[0]
          pair['pair'] = FOUR_OF_A_KIND
          return pair
        end
      end
    end

    # フルハウス
    # カードは2種類のはずなのでそれでわける
    if(@cardSujiList.uniq.size == 2)
        if(@cardSujiList.count(@cardSujiList.uniq[0]) == 2 && @cardSujiList.count(@cardSujiList.uniq[1]) == 3) then
          pair['high'] = "#{@cardSujiList.uniq[1]},#{@cardSujiList.uniq[0]}"
          pair['pair'] = FULL_HOUSE
          return pair
        elsif(@cardSujiList.count(@cardSujiList.uniq[1]) == 2 && @cardSujiList.count(@cardSujiList.uniq[0]) == 3)
          pair['high'] = "#{@cardSujiList.uniq[0]},#{@cardSujiList.uniq[1]}"
          pair['pair'] = FULL_HOUSE
          return pair
        end
    end

    # フラッシュ
    # 絵柄が全部揃っているか
    if(@cardSuitList.uniq.size == 1) then
      pair['high'] = "#{cardSujiListTemp[0]},#{cardSujiListTemp[1]},#{cardSujiListTemp[2]},#{cardSujiListTemp[3]},#{cardSujiListTemp[4]}"
      pair['pair'] = FLUSH
      return pair
    end

    # ストレート
    # カードは5種類のはずなのでそれでわける
    if(@cardSujiList.uniq.size == 5)
      flag = 1

      firstNum = cardSujiListTemp[0]
      # 1ならば処理を変える必要がある
      if(firstNum == 1) then
        for i in (1...cardSujiListTemp.length) do
          if(cardSujiListTemp[i] == 14 - i) then
            flag += 1
          end
        end

      else
        firstNum = @cardSujiList[0]
        for i in (1...@cardSujiList.length) do
          if(@cardSujiList[i] == firstNum - i)
            flag += 1
          end
        end
      end

      if(flag == 5) then
          pair['high'] = firstNum
          pair['pair'] = STRAIGHT
          return pair
      end
    end

    # スリーカード
    for i in 0..cardSujiListTemp.uniq.size do
      if(@cardSujiList.count(@cardSujiList.uniq[i]) == 3)
        pair['high'] = @cardSujiList.uniq[i]
        cardSujiListTemp.delete(pair['high'])
        pair['kicker'] = "#{cardSujiListTemp[0]},#{cardSujiListTemp[1]}"
        pair['pair'] = THREE_OF_A_KIND
        return pair
      end
    end

    # ツーペア
    # カードは3種類のはずなのでそれでわける 
    if(cardSujiListTemp.uniq.size == 3) then
      flag = 0
      for i in 0...3 do
        if(cardSujiListTemp.count(cardSujiListTemp.uniq[i]) == 2)
          pair['high'].concat("#{cardSujiListTemp.uniq[i]}")
          if(flag == 0) then
            pair['high'].concat(",")
          end
          flag += 1
        else
          pair['kicker'] = "#{cardSujiListTemp.uniq[i]}"
        end
      end
      if(flag == 2) then
        pair['pair'] = TWO_PAIR
        return pair
      end
    end

    # ワンペア
    # カードは3種類のはずなのでそれでわける 
    if(@cardSujiList.uniq.size == 4) then
      flag = 0
      for i in 0...4 do
        if(cardSujiListTemp.count(cardSujiListTemp.uniq[i]) == 2) then
          pair['high'] = cardSujiListTemp.uniq[i]
        else
          pair['kicker'].concat("#{cardSujiListTemp.uniq[i]}")
          if(flag != 2)
            pair['kicker'].concat(",")
          end
          flag += 1
        end
      end
      pair['pair'] = ONE_PAIR
      return pair
    end

    # ハイカード
    pair['high'] = "#{cardSujiListTemp[0]},#{cardSujiListTemp[1]},#{cardSujiListTemp[2]},#{cardSujiListTemp[3]},#{cardSujiListTemp[4]}"
    pair['pair'] = HIGH_CARD
    return pair
  end

end


# トランプ格納変数
$trumps = Array.new(MAX_CARD * CARD_TYPE)

# 変数用意しておく
$player = Bunch.new
$com    = Bunch.new

# 初期化
def init 
  
  # トランプを作る
  # カードの種類は4種類…
  for i in (0...CARD_TYPE) do
  
    # カードの数字は1~13まで…
    for j in (1..MAX_CARD) do
      $trumps[((i*MAX_CARD)+j - 1)] = Trump.new(i,j)
    end

  end

  # シャッフル
  $trumps.shuffle!

  # 一時的にカードリストを入れておく
  cardList = Array.new(5)

  # プレイヤーに配る
  for i in (0...5) do
  
    cardList[i] = $trumps[i]
    $trumps.delete_at(i)

  end

  $player.set_card_list(cardList)

  # コンピューターの手札を用意する、初期化する
  cardList  = Array.new(5)
  checkFlag = false; 

  # ワンペア揃わせるまでループ
  while(!checkFlag)
  	num = 0
    # 最初に1枚いれる
    cardList[0] = $trumps[num]
    $trumps.delete_at(num)

    # その1枚の数字を見つけ出す
    for i in (0...$trumps.length) do
      # 数字が同じならそれを入れる
      if($trumps[i].get_suji == cardList[0].get_suji) then

        cardList[1] = $trumps[i]
        $trumps.delete_at(i)
        checkFlag = true

        break

      end
    end
    # ずらす
    num += 1
  end

  # あと3枚いれる
  for i in (2...5) do
    
    cardList[i] = $trumps[i - 2]
    $trumps.delete_at(i - 2)

  end

  # コンピューターの手札
  $com.set_card_list(cardList)
end

def start_game
  
  init

  # ディラー作る(ペア判定)
  diller = Diller.new

  print "ゲーム開始\n\nあなたの手札は\n\n"

  # ソートしてから表示！
  $player.sort_card
  $player.view_myTrumps

  # 役を判定する
  diller.set_card_suji_list($player.get_card_suji_list)
  diller.set_card_suit_list($player.get_card_suit_list)

  print "\n今揃っているペアは"
  # 役を判定
  view_pair(diller.check_pair)

  print "\n手札を交換しますか？"
  
  flag = false
  changeNum = nil
  while(!flag)
    print "\n((NO = 0 / YES = 変えるカードの番号を入力\n例:3,4 -> 3番目と4番目を交換する）) : "
    # 正しく入力され、変更されたらtrueが帰る
    flag = check_change_hand(changeNum = gets.chomp)
  end
  
  if(changeNum != "0") then 
    change_hand(changeNum.split(","))

    # カードを引く
    for i in 0...(MAX_HAND - $player.get_card_list.length) do
      $player.add_card($trumps[i])
      $trumps.delete_at(i)
    end

    print "カードを引きなおしました\n\n"
    
    # ソートしてから表示！
    $player.sort_card
    $player.view_myTrumps
  end

  print "\nショーダウン\n\n"

  $com.sort_card
  # 役を判定する
  diller.set_card_suji_list($com.get_card_suji_list)
  diller.set_card_suit_list($com.get_card_suit_list)

  print "ＣＯＭ : "
  view_pair(comPair = diller.check_pair)

  $player.sort_card
  # 役を判定する
  diller.set_card_suji_list($player.get_card_suji_list)
  diller.set_card_suit_list($player.get_card_suit_list)

  print "あなた : "
  view_pair(playerPair = diller.check_pair)

  wins = check_win(playerPair,comPair)
  # 勝利判定、プレイヤー勝利で"player"
  if(wins == "player") then
    print "\nおめでとうございます、勝ちました"
  elsif (wins == "com") then
    print "\n残念、負けました"
  else
    print "引き分けです"
  end

  print "\n\nリトライします\n\n"

  start_game
end

# プレイヤー勝利でtrue
def check_win(playerPair,comPair)
  # 役の強さが強いほうが勝ち
  if(comPair['pair'] < playerPair['pair']) then
    return "player"

  # 同じ強さならばハイで勝負
  elsif(comPair['pair'] == playerPair['pair']) then
    return check_high(playerPair,comPair)
  else
    return "com"
  end
end

def check_high(playerPair,comPair)
  
  playerHigh = playerPair['high'].to_s.split(",")
  comHigh    = comPair['high'].to_s.split(",")
  # ハイの数だけループ
  for i in (0...playerHigh.length) do
    
    # 数値に変換
    comHigh[i]    = comHigh[i].to_i
    playerHigh[i] = playerHigh[i].to_i

    # 1は+13して1番強くする
    if(comHigh[i] == 1) then
      comHigh[i] += 13
    end

    if(playerHigh[i] == 1) then
      playerHigh[i] += 13
    end

    if(comHigh[i] == playerHigh[i]) then
      # それ以上ハイで勝負できずキッカーがあったらキッカーで勝負
      if(i == (playerHigh.length - 1) && playerPair['kicker'] != "") then
        return check_kicker(playerPair,comPair)
      else
        return false
      end
    elsif(comHigh[i] < playerHigh[i]) then
      return "player"
    elsif(comHigh[i] > playerHigh[i]) then
      return "com"
    end
  end
end

def check_kicker(playerPair,comPair)
  playerKicker = playerPair['kicker'].to_s.split(",")
  comKicker    = comPair['kicker'].to_s.split(",")

  # キッカーの数だけループ
  for i in (0...playerKicker.length) do
    
    # 数値に変換
    comKicker[i]    = comKicker[i].to_i
    playerKicker[i] = playerKicker[i].to_i

    # 1は+13して1番強くする
    if(comKicker[i] == 1) then
      comKicker[i] += 13
    end

    if(playerKicker[i] == 1) then
      playerKicker[i] += 13
    end

    if(comKicker[i] == playerKicker[i]) then
      # それ以上キッカーで勝負できないなら引き分け
      if(i == (playerKicker.length - 1)) then
        return false
      end
    elsif(comKicker[i] < playerKicker[i]) then
      return "player"
    elsif(comKicker[i] > playerKicker[i]) then
      return "com"
    end
  end
end

# 手札を変える
def change_hand(removeArray)
  # 選択したカードを捨てる
  $player.remove_card(removeArray)
end

# 手札を変える値が正しいかチェック
def check_change_hand(changeNum)
  print "\n"

  # 入力されてなければエラー
  if(changeNum == "") then
    print "入力してください"
    return false
  end
  # 全角入力されていたらエラー
  if(/[^ -~｡-ﾟ]/ =~ changeNum)then
    print "全角が入力されています"
    return false
  end

  # 0なら抜ける
  if(changeNum == "0") then
    puts "変えませんでした"
    return true
  end

  changeArray = changeNum.split(",")

  # そもそもArrayにならなかったらエラー
  if(changeArray.class.to_s != "Array") then
    print "入力形式を間違えています"
    return false
  end

  # 配列が5以上にはならないのでなっていたらエラー
  if(5 < changeArray.length)then
    print "配列の数が多すぎます"
    return false
  end

  # 1 ~ 5以外のものが入力されていたらエラー
  for i in 0...changeArray.length do
    if(changeArray[i].to_i < 1 || 5 < changeArray[i].to_i) then
        print "1~5以外が入力されています"
      return false
    end
  end

  # ただしい配列になっていなかったらエラー
  for i in 0...changeArray.length do
    if(changeArray[i].length != 1) then
        print "入力の仕方が正しくありません"
      return false
    end
  end
  # 正しい形で入力された
  return true
end

# 役を表示
def view_pair(pair)
  print "["
  case pair['pair'] 
    when ROYAL_STRAIGHT_FLASH then
      print "ロイヤル・ストレート・フラッシュ"

    when STRAIGHT_FLASH then
      print "#{pair['high']}ハイ・ストレート・フラッシュ"

    when FOUR_OF_A_KIND then
      print "#{pair['high']}のフォーカード #{pair['kicker']}のキッカー"

    when FULL_HOUSE then
      print "#{pair['high']}のフルハウス"

    when FLUSH then
      print "#{pair['high']}ハイ・フラッシュ"

    when STRAIGHT then
      print "#{pair['high']}ハイ・ストレート"

    when THREE_OF_A_KIND then
      print "#{pair['high']}のスリーカード #{pair['kicker']}のキッカー"

    when TWO_PAIR then
      print "#{pair['high']}のツーペア #{pair['kicker']}のキッカー"

    when ONE_PAIR then
      print "#{pair['high']}のワンペア #{pair['kicker']}のキッカー"

    when HIGH_CARD then
      print "#{pair['high']}ハイカード"

    when ERROR then
      print "ERROR"
    else
      print "ノーペア"
  end
  print "]\n"
end

# コード書き始め
start_game
