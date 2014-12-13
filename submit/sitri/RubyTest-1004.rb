# 問1

# 1
a = (1..100).to_a
#p a

# 2
b = a.collect{|b| b*100}
#p b

# 3
c = a.select{|c| c%3==0}
#p c

# 4
d = a.reverse
#p d

# 5
e = a.inject(:+)
#p e

# 6
def sum_array(a1, a2)
  a1.zip(a2).map{|a,b| a+b}
end

#p sum_array((1..100), (2..101))


# 問2
# 1
str_a = "Ruby it is a test string of study for the array".split(' ')
#p str_a

# 2
str_b = str_a.sort
#p str_b

# 3
str_c = str_a.map{|v| v.capitalize}
#p str_c


# 問3
# 1
wday = {
  sunday: "日曜日",
  monday: "月曜日",
  tuseday: "火曜日",
  wednesday: "水曜日",
  thursday: "木曜日",
  friday: "金曜日",
  saturday: "土曜日"
}
#p wday[:sunday]

# 2
#p wday.length

# 3
wday.each do |k,v|
  p "英語[#{k}]は日本語で$#{v}です。"
end


# 問4
# 1
def dice
  rand(6)+1
end
p dice

# 2
def dice10
  result = Array.new(0)
  10.times do
    result<< ( rand(6)+1 )
  end
  return result.inject(:+)
end
p dice10