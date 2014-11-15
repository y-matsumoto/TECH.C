class Checktmp
	def isstr?(game)
		if (/^[0-9]+$/ =~ game)
			return false
		else
			print ("数値じゃない！もう一回\n")
			return true
		end
	end

	def size?(game)
		if game.length != 3
		print ("桁数違う！もう一回\n")
		return true
		end
	end

	def repeat?(game)
		if game[0] == game[1] || game[0] == game[2] || game[1] == game[2]
		print ("重複！もう一回\n")
		return true
		end
	end
end

play = Checktmp.new
cnt = 0
hit = 0
blow = 0
num = [*0..9].sample(3)

while hit < 3
	
	hit = 0
	blow = 0
	print ("number:")
	str = gets.chomp
	
	next if play.isstr?(str)
	if str.to_i == 0
		print ("restart")
		num = [*0..9].sample(3)
		hit = 0
		blow = 0
		next
	end
	cnt += 1
	tmp = str.split("")
	
	tmp.map! do |i|
		i = i.to_i
	end
	p tmp
	
	next if play.size?(tmp) 
	next if play.repeat?(tmp)

	for x in 0..2
		y = num.index(tmp[x])
			if x == y
				hit += 1
			
			elsif y != nil
				blow += 1
			
			end
	end

	p ("#{hit}Hit#{blow}Blow")
end

print ("全#{cnt}回")
