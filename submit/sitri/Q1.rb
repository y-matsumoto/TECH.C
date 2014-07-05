for i in 1..9
    for j in 1..9
        printf("%02d ", i*j);
    end
    print "\n"
end

print "\n"

(1..9).each do  |a|
    (1..9).each do |b|
        printf("%02d ", a*b)
    end
    print "\n"
end