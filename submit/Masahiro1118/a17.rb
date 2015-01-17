#encoding:utf-8

require 'mechanize'
require 'nokogiri'
require 'open-uri'

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
      db.execute("DROP TABLE IF EXISTS news")
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


agent = Mechanize.new
pages = Array.new()
hm = Array.new()
awk = Array.new(25*9){[]}

sq = Datas.new
sq.create_table

pages[0] = agent.get('http://news.yahoo.co.jp/flash')
hm[0]    = Nokogiri::HTML(pages[0].body)

for i in 0..7 do
  pages[i+1] = pages[i].link_with(:text => "#{i+2}").click
  hm[i+1] = Nokogiri::HTML(pages[i+1].body)
end

for i in 0...hm.size do
  num = i * 25
  hm[i].xpath('//div[@class = "articleList lastCon"]/ul/li/p/a').each do |node|
    # URL取り出し
    awk[num][URL] = node[:href]
    # タイトル取り出し
    awk[num][TITLE] = node.text
    num += 1
  end

  num = i * 25
  # URL取り出し
  hm[i].xpath('//div[@class = "articleList lastCon"]/ul/li/p[@class = "source"]').each do |node|
    a = node.text.split(" ")
    awk[num][OFFER] = a[0]
    awk[num][TIME] = a[1]
    num += 1
  end

end

for i in 0...awk.size do 
  sq.insert_data(awk[i])
end

sq.view