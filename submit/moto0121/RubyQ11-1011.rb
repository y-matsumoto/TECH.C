def wc(file)
	lines = words = chars = 0
	file = File.open(file,"r")

	while line = file.gets
	lines += 1
	chars += line.length
	wordArray = line.split(/\s+/).reject{|w| w.empty?}
	words += wordArray.length
	end

puts "lines=#{lines} words =#{words} chars=#{chars}"
end

wc(ARGV[0])





def tail(gyo,filename)
	lines = 0
	file = File.open(filename,"r")

	while line = file.gets
	lines += 1
	end

end

tail(ARGV[0].to_i,ARGV[1])
