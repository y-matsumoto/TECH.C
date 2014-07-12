
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

p ""
# each
(1..9).each do  |a|
    (1..9).each do |b|
        printf("%02d ", a*b)
    end
    print "\n"
end