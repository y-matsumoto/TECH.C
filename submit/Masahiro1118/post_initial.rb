# SQLiteに住所情報を登録する
require 'sqlite3'

dbname = 'rb14'
fileName = 'KEN_ALL.CSV' 

COL_ZIP  = 2
COL_PREF = 6
COL_CITY = 7
COL_ADDR = 8

# 保存するCSVファイルが存在するか
if(File.exists?(fileName) == false)
  puts "[failure : [#{fileName}]が存在しません]"
else

  SQLite3::Database.open(dbname) do |db|
    db.execute("DROP TABLE zips")
    db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS zips
    (code TEXT,pref TEXT,city TEXT,addr TEXT,alladdr TEXT,kana TEXT)
    SQL

    File.open(fileName,'r:shift_jis') do |zip|
    db.execute "BEGIN TRANSACTION"
    zip.each_line do |line|
      columns = line.split(/,/).map{|col| col.delete('"')}
      code = columns[COL_ZIP]
      pref = columns[COL_PREF]
      city = columns[COL_CITY]
      addr = columns[COL_ADDR]
      kana = columns[3] + columns[4] + columns[5]
      all_addr = pref+city+addr
      db.execute "INSERT INTO zips VALUES(?,?,?,?,?,?)",
      [code,pref,city,addr,all_addr,kana]
    end
    db.execute "COMMIT TRANSACTION"
    end
  end

  puts "[success]"
end