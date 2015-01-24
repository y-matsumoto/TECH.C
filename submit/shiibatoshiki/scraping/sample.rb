#encoding: utf-8

page = open("index.html", &:read)
datex = page.scan(%r!(\d+)-(\d+)-(\d+)<br/>!)
p dates

links = page.scan(%r!^<a href="(.+?)">(.+?)</a>!)
p links