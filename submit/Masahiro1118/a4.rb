class Card

	def initialize
		checkFlag = false
		@cardList = Array.new(2)

		# 当てるカードをセット、ただし数値のかぶりが無いようにする
		while(!checkFlag)
			@cardList = [[*0..9].sample,[*0..9].sample,[*0..9].sample]
			# p @cardList
			if @cardList.size == @cardList.uniq.size then
				checkFlag = true
			end
		end
		# p @cardList
	end

	# ユーザーが選んだデータが入っているか
	def check_num(playerNum,turn)
		hit  = 0
		blow = 0
		num  = Array.new(2)

		# playerNumを配列に
		for i in 0..num.length do
			num[i] = playerNum[i].to_i
		end

		print "あなたが選んだ数値 :"
		p num

		# num要素分だけループ
		for i in 0..num.length - 1 do
			# cardList要素文だけループ
			if num[i] == @cardList[i] then
				hit += 1

			else
				# 違うところに同じ番号のカードがあるか
				for j in 0..@cardList.length - 1 do
					if num[i] == @cardList[j] then
						blow += 1
					end
				end
			end			
		end
		if hit == 3 then
			puts("おめでとうございます正解です かかったターン#{turn}")
			return false
		else
			puts("hit : #{hit} blow:#{blow}")
			return true
		end
	end
end

card = nil
gameFlag = true
turn = 0

puts("ゲームスタート！")
card = Card.new

while(gameFlag)
	
	puts ("数を入力してください(0=リセット)")
	playerNum = gets.chomp

	if playerNum.to_s.length == 1 then

		if playerNum.to_i == 0 then
			puts("リセットしました")
			card = Card.new
			turn = 0
		else
			puts("**入力エラーです**")
		end

	elsif playerNum.to_s.length == 3 then

		if (playerNum[0].to_i == playerNum[1].to_i) && (playerNum[1].to_i == playerNum[2].to_i) then
			puts("3つとも同じ数値はできません")
		else
			turn += 1
			gameFlag = card.check_num(playerNum,turn)
		end

	else
		puts("**入力エラーです**")
	end
end

def init
	card = Card.new
end