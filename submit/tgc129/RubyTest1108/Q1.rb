#(1)downto・・・オブジェクトの値がminの値になるまで繰り返し
mark = '*'
5.downto(1){|num| print((mark * num) + "\n")}

#(2)要素１から最大数-1までの値の順番を逆にする。
ary = [1,2,3,4,5]
ary.reverse!
p ary[1...-1]

#(3)配列の中から条件に合うものだけを表示
ary = (-15..-10).to_a
p ary.select{|i| i % 3 == 0}

#(4)同一オブジェクトかチェックする
o1 = Object.new
o2 = Object.new

if o1.equal?(o2)
  puts("o1")
else
  puts("o2")
end

#(5)配列の最後の要素から1番目と2番目を足して配列に追加していく
def test(count=9)
  count -= 2
  container = [0,1]
  until 0 >= count
    container += [(container[-2] + container[-1])]
    count -= 1
  end
  return container
end
p test