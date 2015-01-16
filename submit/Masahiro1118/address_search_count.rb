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

  def search_address_count(address)
    sql = "SELECT * FROM #{@tableName} WHERE alladdr LIKE ?"
    count = 0
    SQLite3::Database.open(@dbname) do |db|
      db.execute(sql,"%#{address}%") do |num|
        count += 1
  	  end
    end
    return count
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
  puts "住所の一部を入力してください"
else
  num = db.search_address_count(ARGV[0])
  puts "[count = #{num}]"
end 

# -------------------------------------------

