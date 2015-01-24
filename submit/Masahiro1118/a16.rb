
require 'open-uri'
require 'nokogiri'


TITLE  = 0
URL    = 1
OFFER  = 2
TIME   = 3
DATES  = 4

class Datas
  require 'sqlite3'
  def initialize
    @dbname = 'rb16'
  end

  def create_table
  	SQLite3::Database.open(@dbname) do |db|
      db.execute("DROP TABLE news")
      db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS news
        (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,url TEXT,offer TEXT,time TEXT,dates TEXT)
      SQL
    end
  end

  def insert_data(awk)
    SQLite3::Database.open(@dbname) do |db|
      db.execute "BEGIN TRANSACTION"

      db.execute"INSERT INTO news(title,url,offer,time,dates) VALUES(?,?,?,?,?)",
      [awk[TITLE],awk[URL],awk[OFFER],awk[TIME],Time.now.strftime("%Y-%m-%d %H:%M:%S")]
      
      db.execute "COMMIT TRANSACTION"
    end
  end

  def view
    SQLite3::Database.open(@dbname) do |db|
      db.execute("SELECT * FROM news") do |r|
        puts "ID [#{r[0]}]"
        puts "タイトル　[#{r[1]}]"
        puts "URL [#{r[2]}]"
        puts "提供媒体 [#{r[3]}]"
        puts "表示時間 [#{r[4]}]"
        puts "取得日時 [#{r[5]}]"
      end
    end
  end

end

hm = Nokogiri::HTML(open("http://news.yahoo.co.jp/flash"))
num = 0

sq = Datas.new
sq.create_table

awk = Array.new(25) { [] }

hm.xpath('//div[@class = "articleList lastCon"]/ul/li/p/a').each do |node|
  # URL取り出し
  awk[num][URL] = node[:href]
  
  # タイトル取り出し
  awk[num][TITLE] = node.text
  num += 1
end

num = 0
# URL取り出し
hm.xpath('//div[@class = "articleList lastCon"]/ul/li/p[@class = "source"]').each do |node|
  a = node.text.split(" ")
  awk[num][OFFER] = a[0]
  awk[num][TIME] = a[1]
  num += 1
end

for i in 0...awk.size do 
  sq.insert_data(awk[i])
end

sq.view