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

  def search_address(address)
    sql = "SELECT * FROM #{@tableName} WHERE alladdr = ?"
    SQLite3::Database.open(@dbname) do |db|
      db.execute(sql,"#{address}") do |num|
      	return num 
  	  end
    end
    return false
  end

end

# -------------------------------------------

# データベース操作クラス
db = DBc.new()
# データ存在チェック
if db.check_table? == false
	puts "[post_initial.rb]を実行してください"
end

if ARGV[0] == nil
  puts "住所を入力してください"
else
  # 検索
  post = db.search_address(ARGV[0])
    
  if post == false
    # 存在しない
    puts "その住所は存在しません"
  else
    # 存在する
    puts "[[#{post[4]}] (#{post[5]})]"
  end  
end
# -------------------------------------------

