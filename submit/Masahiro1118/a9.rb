
DATABASE_NAME = "janken"
TABLE_NAME    = "janken_rankings"

JANKEN  = 1
RANKING = 2

GU    = 0
CHOKI = 1
PAA   = 2

AIKO  = 0
WIN   = 1
LOSE  = 2


require 'active_record'

class RankingManager
  # なんか使うやつ
  require 'rubygems'
  require 'sqlite3'
  
  def initialize(activeRecordClassName)
    @db = SQLite3::Database.new(DATABASE_NAME)
	@db.execute("CREATE TABLE IF NOT EXISTS #{TABLE_NAME} (date text,result text)")
	@db.close

	@activeRecord = activeRecordClassName

  end

  def set_record(result)
	table = @activeRecord.new(result)
	table.save
  end
	
  def get_record_all
    return @activeRecord.all 
  end

  def delete_all
	@activeRecord.delete_all
  end
end
# ActiveRecordの設定	
ActiveRecord::Base.establish_connection(
"adapter"=>"sqlite3",
"database"=>"./#{DATABASE_NAME}")

# ActiveRecordクラス
class JankenRanking < ActiveRecord::Base
end


# ランキングを表示させる
def show_ranking(ranking)
  for i in (0...ranking.size) do
    puts "#{ranking[i]["date"]} #{ranking[i]["result"]}"
  end
end

def check_input(input)
  if (input == 1 || input == 2) then
  	return true
  else
  	print "ERROR : 1か2を入力してください\n"
  	return false
  end
end

def check_janken_input(input)
  if (input == 0 || input == 1 || input == 2) then
  	return true
  else
  	print "ERROR : 0か1か2を入力してください\n"
  	return false
  end
end

def start_janken
  
  # 正しい値かチェック
  flag = false
  input = nil
  while(!flag)
  	print "\n[じゃんけん]\nグー:0 チョキ:1 パー:2 >> "
    flag = check_janken_input(input = gets.chomp.to_i)
  end

  result = result_janken(input)

  # 勝ち負け判定処理
  if(result == AIKO) then
  	return "あいこ"
  elsif (result == WIN)
  	return "勝ち"
  else
  	return "負け"
  end
end

def result_janken(hand)
  # comの出した手を設定
  comHand = rand(2)

  print "自分 : #{hand_janken(hand)} あいて : #{hand_janken(comHand)}\n"
  # 処理
  if(comHand == hand) then
  	return AIKO
  end

  case(hand)
    when GU
      return comHand == CHOKI ? WIN : LOSE
  	when CHOKI
      return comHand == PAA ? WIN : LOSE
  	when PAA
  	  return comHand == GU ? WIN : LOSE
  		
  end
end

def hand_janken(hand)
  if(hand == GU)
  	  return "グー"
    elsif (hand == PAA)
  	  return "パー"
    elsif (hand == CHOKI)
  	  return "チョキ"
  end
  		
end

# -----------------
# DB操作変数
manager = RankingManager.new(JankenRanking)

# 正しい値かチェック
flag = false
input = nil
while(!flag)
  print "[メニュー]\n1:じゃんけんする 2:ランキングを見る >> "
  flag = check_input(input = gets.chomp.to_i)
end

# 入力した値によって変える
if(input == JANKEN) then
  result = start_janken
  puts "#{result}でした。"
  day = Time.now
  manager.set_record(:date => "#{day.month}月#{day.day}日 #{day.hour}時#{day.min}分",:result => result)
elsif(input == RANKING)
  show_ranking(manager.get_record_all)
else
  puts "ERROR : 予想外の数値が入っているため強制停止します"
end