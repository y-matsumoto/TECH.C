
問１
mark = '*'
5.downto(1) {|i| print((mark * i) + "\n") }

downto -> 指定数値分ループ、minまで繰り返す

-----------
# 5 4 3 2 1 回ループ
*****
****
***
**
*
-----------
問２
ary = [1, 2, 3, 4, 5]
ary.reverse!
p ary[1...-1]

reverse -> 指定配列の並びを逆にする

-----------
# 1 < -1(配列の最後)
[4,3,2]
-----------

問３
ary = (-15..-10).to_a
p ary.select {|i| i % 3 == 0}

to_a -> 配列にする
select -> 条件に合う要素を探して表示

-----------
# [-15,-14,-13,-12,-11,-10] -> 3で割れるもの
[-15,-12]
-----------

問４
o1 = Object.new
o2 = Object.new
if o1.equal?(o2)
puts("o1")
else
puts("o2")
end

equal? -> そのオブジェクトと同じオブジェクトか

-----------
# 異なる参照のオブジェクト同士なので同じでは無い
o2
-----------

問５
def test(count=9)
count -= 2 # count = 7
container = [0, 1]
until 0 >= count # 7回ループ
container += [(container[-2] + container[-1])]
count -= 1
end
return container
end
p test

until -> whileの逆 条件が偽の場合ループする

-----------
[0,1,1,2,3,5,8,13,21]
-----------

問６
class Tool
def use
puts "color:#{@color} tool:#{self.class.to_s}"
end
def initialize(color)
@color = color
end
end
Hammer.new("red").use