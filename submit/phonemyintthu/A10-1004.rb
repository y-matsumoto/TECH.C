#PhoneMyintThu
class Array
  def quick_sort
    return self if self.size <= 1
    pivot = self[0]
    right = Array.new
    left = Array.new
    (1..self.size-1).each do |i|
      if self[i] <= pivot
        left.push(self[i])
      else
        right.push(self[i])
      end
    end
    left = left.quick_sort
    right = right.quick_sort
    return left + [pivot] + right
  end
end

def integer_string?(str)
  Integer(str)
  true
rescue ArgumentError
  false
end

a = Array.new
MAX = 10

for i in (0...MAX) do
  print "Please Enter : "
  begin
  	flag = false
    num = gets.to_s
    if (!integer_string?(num))
      print "Input Value : "
      flag = true
    else
      a.push(Integer(num))
    end
  end while(flag)
end

p a.quick_sort