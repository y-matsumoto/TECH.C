require 'sqlite3'

# DB操作用
class DBc

  def initialize
    @dbname = 'rb14'
    @tableName = 'zips'
  end

  def check_table?
  	# 0の場合テーブルは存在しない
  	sql = "SELECT COUNT(*) from sqlite_master where type='table' and name = ?;"
  	SQLite3::Database.open(@dbname) do |db|
  	  db.execute(sql,@tableName) do |num|
  	  	if (num[0] == 0)
  	  	  return false
  	  	end
  	  end
  	end
  return true
  end

  def search_post(post)
    sql = "SELECT * FROM #{@tableName} WHERE code = ?"
    SQLite3::Database.open(@dbname) do |db|
      db.execute(sql,"#{post}") do |num|
      	return num 
  	  end
    end
    return false
  end

end

def integer_string?(str)
  Integer(str)
  true
rescue ArgumentError
  false
end

# -------------------------------------------

# データベース操作クラス
db = DBc.new()
# データ存在チェック
if db.check_table? == false
	puts "[post_initial.rb]を実行してください"
end

if ARGV[0] == nil
  puts "郵便番号を入力してください"
else
  # 数値かどうか確認
  if integer_string?(ARGV[0])  
    
    # 検索
    post = db.search_post(ARGV[0])
    
    if  post == false
      # 存在しない
      puts "その郵便番号は存在しません"
    else
      # 存在する
      puts "[[#{post[4]}] (#{post[5]})]"
    end
  
  else
  puts "数値を入力してください"
  end
end
# -------------------------------------------

