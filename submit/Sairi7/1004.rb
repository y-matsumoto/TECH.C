p a = (1..100).to_a.sort
p b = a.collect {|x|x * 100}
p c = a.select {|x|x % 3 == 0}
p d = a.reverse

