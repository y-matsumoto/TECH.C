#! ruby -Ks
require 'uri'

module Search
	def google(key)
		URI.escape("http://www.google.co.jp/search?q=#{key}")
	end
end

class Book
	include Search
end

class City
	include Search
end
p Book.new.google("たのしいRuby")
p City.new.google("新宿区")

