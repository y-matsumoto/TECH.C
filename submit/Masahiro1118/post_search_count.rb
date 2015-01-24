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

  def search_post_count(post)
    sql = "SELECT * FROM #{@tableName} WHERE code LIKE ?"
    count = 0
    SQLite3::Database.open(@dbname) do |db|
      db.execute(sql,"#{post}%%%%") do |num|
      	count += 1
  	  end
    end
    return count
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
  puts "郵便番号の一部を入力してください"
else
  
  if integer_string?(ARGV[0])    
    # 検索結果を表示
    num = db.search_post_count(Integer(ARGV[0]))
    puts "[count = #{num}]"
  else
    puts "数値を入力してください"
  end
end 

# -------------------------------------------

