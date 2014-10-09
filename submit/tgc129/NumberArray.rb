class NumberArray

  def initialize()
    @a = Array.new
    100.times{|i| @a[i] = i+1}
          p @a
  end

  def array1
    p @a
  end

  def array2()
    b = Array.new
    @a.each{|n|
      b[n-1] = n*100
    }
    p b
  end

  def array3
    cn=0
    c = Array.new
    @a.each{|n|
      if (n%3==0) then
        c[cn] = n
        cn+=1
      end
    }
    p c
  end

  def array4
    p @a.reverse
  end

  def array5
    sum = 0
    @a.each{|n|
      sum += n
    }
    p sum
  end
end

na = NumberArray.new()
na.array1
na.array2
na.array3
na.array4
na.array5