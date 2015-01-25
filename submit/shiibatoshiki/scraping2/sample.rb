#encoding: utf-8

require 'nokogiri'

xml = Nokogiri::XML(open("sample.xml", &:read))

xml.xpath('/catalog/book').each do |item|
    puts item.xpath('author').text
    puts item.xpath('title').text
    puts item.xpath('genre').text
    puts item.xpath('price').text
    puts item.xpath('publish_date').text
    puts item.xpath('description').text
end