require 'uri'
module Search
  def google(str)
    return 'http://www.google.co.jp/search?q=' + URI.escape(str)
  end
end

class City
  include Search
  attr :name
  def initialize(str)
    @name = str
  end
  def google()
    return super(@name)
  end
end

class Book
  include Search
  attr :title
  def initialize(str)
    @title = str
  end
  def google()
    return super(@title)
  end
end


book = Book.new("たのしいRuby")
puts book.google
city = City.new("新宿区")
puts city.google