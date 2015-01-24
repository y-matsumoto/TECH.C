require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'date'
require 'sqlite3'
agent = Mechanize.new

class Common
  @@url =''
  def getUrl
    @@url
  end
  #読み込むurl先
  def setUrl(url, str)
    @@url = url + str.to_s
  end
end

class Scraping < Common
  def create_html_obj
    html = open(@@url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    # htmlをパース(解析)してオブジェクトを作成
    @doc = Nokogiri::HTML.parse(html, nil, charset =nil)
  end
  
  def getObj
    db = SQLite3::Database.new("RubyQ16_17.db")
    @doc.xpath('//ul[@class="listBd"]/li').each do |node|
        # 記事のtitle
        title = node.css('a').inner_text
        # 記事のurl
        url = node.css('a').attribute('href').value
        #提供媒体
        addres = node.css('span').inner_text
        #記事の時刻
        str = node.css('p').inner_text
        strNum = str.length.to_i
        time = str[(strNum-6)..strNum]
        
        get_time = Date.today
          
        db.execute("insert into newsBook (title,url,addres,time,get_time) values('#{title}', '#{url}', '#{addres}', '#{time}', '#{get_time}')")
    end
    db.close
  end
end
test = Scraping.new
#ページを取得
for i in 1..9
  test.setUrl("http://news.yahoo.co.jp/flash?p=",i)
  test.create_html_obj
  test.getObj()
 puts
  
end