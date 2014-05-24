class Card

	def initialize
		# 当てるカードをセット
		@cardList = Array.new(2)
		@cardList = [[*0..9].sample,[*0..9].sample,[*0..9].sample]
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

puts("ゲームスタート！")
card = Card.new

while(gameFlag)
	turn = 0

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
		turn += 1
		gameFlag = card.check_num(playerNum,turn)

	else
		puts("**入力エラーです**")
	end
end

def init
	card = Card.new
end