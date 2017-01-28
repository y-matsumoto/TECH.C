class Box
  BOX = ["abcd","efgh","cbad","ssss"]
  @@cnt = 0#入力の回数
  @@hand = []
  @@score = 0#正解の回数

  def cntGet
    @@cnt
  end

  def scoreGet
    @@score
  end

  #ランダムで出題
  def randomOut
    while true
      str = BOX.sample
      if questionCheck?(str)
        next
      else
        @@hand.push(str)
        break
      end
    end
    str
  end

  #答えのチェック
  def answerCheck?(str)
    @@cnt += 1
    @@score += 1if questionCheck?(str)
    questionCheck?(str)
  end

  #時間の記録
  def timer
    return a = Time.now if @@cnt == 0
    return b = Time.now if @@score == BOX.length
  end

  #時間の計算
  def timeOut(a,b)
    total_time = b - a
  end

  #問題の重複のチェック/正解のチェック
  def questionCheck?(str)
    true if @@hand.include?(str)
  end
end

play = Box.new
p "game start!!"
a,b = 0
while true
  p question = play.randomOut
  a = play.timer if play.cntGet == 0
  while true
    str = gets.chomp
    if play.answerCheck?(str)
      break
    else
      p 'error'
      p question
    end
  end
  if play.scoreGet == 4
    b = play.timer
    break
  end
end
total_time = play.timeOut(a,b)
p "時間:#{total_time}sec"
p "入力回数:#{play.cntGet}"
