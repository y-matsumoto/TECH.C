class Dice

  def diceShow
    p rand(6.5)+1
  end

  def diceSum
      i=0
      sum = 0
      while i<10
        sum += rand(6.5)+1
        i = i+1
      end
      p sum
  end
end

dice = Dice.new
dice.diceShow
dice.diceSum