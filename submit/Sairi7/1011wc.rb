def wc(file)
	lines = 0
	words = 0
	chars = 0
	file = File.open(file, "r")

	while line = file.gets
		lines += 1
		chars += line.length
		wordArray = line.split(/\s+/).reject{|w| w.empty?}
		words += wordArray.length
	end

	put "lines=#{lines} words=#{words} chars=#{chars}"
end

wc(ARVG[0])

