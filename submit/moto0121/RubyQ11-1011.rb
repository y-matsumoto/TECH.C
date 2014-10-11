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