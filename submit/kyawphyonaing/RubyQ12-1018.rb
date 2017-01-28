module GoogleEncoder
  def encode(words)
  	require 'uri'
    URI.escape("http://www.google.co.jp/search?q=#{words}")
  end
end

class Book
  include GoogleEncoder
  
  def initialize(word)
    @word = word
  end

  def google
  	return encode(@word)
  end

end

class City
  include GoogleEncoder
  
  def initialize(word)
    @word = word
  end

  def google
    return encode(@word)
  end

end

book = Book.new("たのしいRuby")
puts book.google
city = City.new("新宿区")
puts city.google