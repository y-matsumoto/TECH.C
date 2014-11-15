
# Hello World!\nを５回
# for
for i in 1..5 
    p "Hello World!"
end

# times
5.times do
    p "Hello World!"
end


# 九九表
# for
for i in 1..9
    for j in 1..9
        printf("%02d ", i*j);
    end
    print "\n"
end

print "\n"

# each
(1..9).each do  |a|
    (1..9).each do |b|
        printf("%02d ", a*b)
    end
    print "\n"
end

print "\n"


# FizzBuzz
for i in 1..100
    is_FizzBuzz = false
    
    # ３で割り切れたら、Fizzを表示
    if i % 3 == 0
        print "Fizz"
        is_FizzBuzz = true
    end
    
    # ５で割り切れたら、Buzzを表示
    if i % 5 == 0
        print "Buzz"
        is_FizzBuzz = true
    end
    
    # FizzBuzzじゃなければ、数値を表示
    unless is_FizzBuzz
        print i
    end
    
    # 改行
    print "\n"
    
end
