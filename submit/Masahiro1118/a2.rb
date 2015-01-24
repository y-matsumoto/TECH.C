=begin
  引数までの素数を表示します。
  @param {int} num どこまで表示するか
=end
def primeNumber(num)
	prime_list = [2]
	x = 3
	while x < num
	  found = false
	  for y in prime_list
	    if y * y > x
	      found = true
	      break
	    end
	    break if x % y == 0
	  end
	  prime_list.push(x) if found
	  x += 2
	end
	print prime_list
end

#class Leap
=begin
	引数までの年数の閏年を表示します
	@param year {int} どの年まで表示するか
=end
	def leapYear(year)
		leapYearList = []
		for i in 0..year do
			y = i
			if (y %= 4) == 0 then
				leapYearList.push(i)
			elsif (y %= 100) == 0 then
				leapYearList.push(i)
			elsif (y %= 400) == 0 then
				leapYearList.push(i)
			end
		end
		print leapYearList
	end
#end

#primeNumber(100)
leapYear(2014)

#tmp = Leap.new()
#tmp.leapYear