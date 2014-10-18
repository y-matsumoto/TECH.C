def kadai1_1
  a = Array.new
  for i in (1..100)
  	a.push(i)
  end
  p a
end

def kadai1_2
  a = Array.new
  for i in (1..100) do
  	a.push(i)
  end

  b = Array.new
  for i in (1..a.size) do
  	b.push(i*100)
  end
  p b
end

def kadai1_3
  a = Array.new
  for i in (1..100) do
  	a.push(i)
  end

  c = Array.new
  for i in (1..a.size) do
  	if(i % 3 == 0)
  	  c.push(i)
  	end
  end
  p c
end

def kadai1_4
  a = Array.new
  for i in (1..100) do
  	a.push(i)
  end
  p a.reverse
end

def kadai1_5
  a = Array.new
  for i in (1..100) do
  	a.push(i)
  end

  hoge = 0
  for i in (0...a.size) do
  	hoge += a[i]
  end
  p hoge
end

def sum_array(a,b)
  # 要素数が違う場合はエラー
  if a.size != b.size
  	puts "配列の要素数が違います"
  else
  	c = Array.new
  	for i in (0...a.size) do
  	  c.push(a[i] + b[i])
  	end
  	return c
  end
end

def kadai2_1
  p "Ruby,it,is,a,test,string,of,study,for,the,array".split(",")
end

def kadai2_2
  a = Array.new
  a = "Ruby,it,is,a,test,string,of,study,for,the,array".split(",")
  p a.sort{ |a,b| a.downcase <=> b.downcase }
end

def kadai2_3
  a = Array.new
  a = "Ruby,it,is,a,test,string,of,study,for,the,array".split(",")
  for i in (0...a.size) do 
  	print a[i].capitalize + ","
  end
  puts ""
end

def kadai3_1
  wday = {:monday => "月曜日",:tuesday => "火曜日",:wednesday => "水曜日",:thursday => "木曜日",:friday => "金曜日",:saturday => "土曜日",:sunday => "日曜日"}
end

def kadai3_2
  wday = {:monday => "月曜日",:tuesday => "火曜日",:wednesday => "水曜日",:thursday => "木曜日",:friday => "金曜日",:saturday => "土曜日",:sunday => "日曜日"}
  p wday.length
end

def kadai3_3
  wday = {:monday => "月曜日",:tuesday => "火曜日",:wednesday => "水曜日",:thursday => "木曜日",:friday => "金曜日",:saturday => "土曜日",:sunday => "日曜日"}
  wday.each{|key,val|
    puts "英語[#{key}]は日本語で#{val}です。"
  }
end

def dice
  return rand(6) + 1
end

def dice10
  hoge = 0
  for i in 0...10 do
  	hoge += rand(6) + 1
  end
  return hoge
end

kadai1_1
kadai1_2
kadai1_3
kadai1_4
kadai1_5
p sum_array([1,2,3],[4,5,6])

kadai2_1
kadai2_2
kadai2_3

kadai3_1
kadai3_2
kadai3_3

p dice
p dice10