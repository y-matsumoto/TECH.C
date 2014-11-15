require 'uri'

module Serch
    @@url = "http://www.google.co.jp/search?q="
end

class Book
  include Serch
  def initialize(bname)
    @@bookname = @@url + bname
  end

  def view
    puts URI.escape(@@bookname)
  end
end

class City
  include Serch
  def initialize(cname)
    @@cityname = @@url + cname
  end

  def view
    puts URI.escape(@@cityname)
  end
end

book = Book.new("たのしいRuby")
puts book.view
city = City.new("新宿")
puts city.view