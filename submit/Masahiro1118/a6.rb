# 定数
ERROR = -1

MAX_HAND  = 2
MAX_CARD  = 13
CARD_TYPE = 4

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

  def set_card_list(cardList)
    @cardList = cardList
  end

  def get_card_list
    @cardList
  end

  def get_list_to_num(num)
    @cardList[num]
  end

  def add_card(card)
    @cardList.push(card)
  end

  def get_card_length
    @cardList.length
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
  cardList = Array.new(MAX_HAND)

  # 最初に1枚いれる(6以上のカードじゃないとエラーが出るのでそこら辺もしっかりと)
  for i in (0...$trumps.length) do
    if(6 <= check_card_num(0,$trumps[i].get_suji)) then
      cardList[0] = $trumps[i]
      $trumps.delete_at(i)
      break 
    end
  end

  # その1枚を足して16になるように調整する
  for i in (0...$trumps.length) do
    # 16以上になった数を入れる
    if(16 <= (check_card_num(0,cardList[0].get_suji) + check_card_num(0,$trumps[i].get_suji))) then

      # ただしもう1が入っている状態で1ならば入れない
      if (cardList[0].get_suji != $trumps[i].get_suji)then
        cardList[1] = $trumps[i]
        $trumps.delete_at(i)
        break
      end
    end
  end

  # コンピューターの手札
  $com.set_card_list(cardList)

  # 初期化する
  cardList  = Array.new(MAX_HAND)
  
  # プレイヤーに配る
  for i in (0...MAX_HAND) do
  
    cardList[i] = $trumps[i]
    $trumps.delete_at(i)

  end

  $player.set_card_list(cardList)
end

def game_start
    init

    while ( !(22 <= get_total($player.get_card_list)))

    view_player_card

    flag = false
    changeNum = nil
    while(!flag)
      print "\nどうしますか？(0->スタンド 1->ヒット) : "
      # 正しく入力され、変更されたらtrueが帰る
      flag = check_hit_or_stand(changeNum = gets.chomp)
    end

    if(changeNum.to_i == 0) then
      show
      break
    end

    if(changeNum.to_i == 1)then
      $player.add_card($trumps[0])
      $trumps.delete_at(0)
      if(21 < get_total($player.get_card_list)) then
        view_player_card
        print "[バーストしました]\n"
      end
    end
  end

  print "\nリトライします\n\n"

  game_start
end

# カードのリストを確認して21以上ならばfalseを返す
def check_twentyone(cardList)
  for i in (0...MAX_HAND) do

  end
end

# 21以上ならば1は1以下ならば11JQKは10にする 
def check_card_num(totalNum,num)
  one = 11
  if(21 < totalNum) then
    one = 1
  end

  case num
  when 1 then
    return one
  when 11 then
    return 10
  when 12 then
    return 10
  when 13 then
    return 10
  end

  return num
end

def get_total(cardList)
  total = 0
  for i in (0...check_card_num(0,cardList.length)) do
    total += check_card_num(0,cardList[i].get_suji)
  end
  total
end

def check_hit_or_stand(num)
  # 入力されてなければエラー
  if(num == "") then
    print "入力してください"
    return false
  end
  # 全角入力されていたらエラー
  if(/[^ -~｡-ﾟ]/ =~ num)then
    print "全角が入力されています"
    return false
  end

  # 数値以外なら
  if(num !~ /\A-?\d+(.\d+)?\Z/) then
    print "数値で入力してください"
    return false
  end
  # numが0と1以外
  if(num.to_i < 0 || 1 < num.to_i) then
    print "0か1を入力してください"
    return false
  end

  return true
end

def view_player_card
  print "あなたの手札は"
  for i in (0...$player.get_card_length) do
    print "[#{$player.get_list_to_num(i).get_suji}]"
  end
  print "(合計:#{get_total($player.get_card_list)})\n"
end

def show
  print "\nあなた : #{get_total($player.get_card_list)}"
  print "\nＣＯＭ : #{get_total($com.get_card_list)}\n\n"

  if(get_total($player.get_card_list) == get_total($com.get_card_list))then
    print "[引き分けです]"
  
  elsif(get_total($player.get_card_list) == 21) then
    print "[あなたの勝ちです]"
  
  elsif(get_total($com.get_card_list) == 21) then
    print "[あなたの負けです]"

  elsif(get_total($com.get_card_list) < get_total($player.get_card_list))
    print "[あなたの勝ちです]"
  elsif(get_total($player.get_card_list) < get_total($com.get_card_list))
    print "[あなたの負けです]"
  end
end

game_start