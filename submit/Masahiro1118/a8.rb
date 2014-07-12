class Timer
  
  # 開始時間を入れる
  def initialize(timeStart)
  	@timeStart = timeStart
  end

  # タイマーを終了させる
  def end_timer(timeEnd)
  	# 四捨五入する
  	return (timeEnd - @timeStart).round
  end
end

# プログラムスタート

# 問題を固定で作る
question = ["dwadj","wjiea","jhpak","waugr","wyrhz","wdahr"]

puts "Game Start!"

nowQuestion = 0
turn = 0;

timer = Timer.new(Time.now)
# クイズが終了するまでループ
while(true)
  turn += 1
  
  puts "問 : #{nowQuestion+1} #{question[nowQuestion]}"
	
  if(question[nowQuestion] == gets.chomp) then
  	puts "正解です！"
    nowQuestion += 1

    if (nowQuestion == question.size) then
      puts "ゲーム終了です[回答回数 : #{turn}][かかった時間 : #{timer.end_timer(Time.now)}秒]"
      break
    end
  else
  	puts "不正解です"
  end
end