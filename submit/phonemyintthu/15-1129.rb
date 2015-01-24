#PhoneMyintThu

require 'thor'

class Wcex < Thor	
	
	desc 'wcex' , ' aa'
	option :full, :type => :boolean, :aliases => '-f' , :desc => "all"
	option :byte, :type => :boolean, :aliases => '-c' , :desc => "byte"
	option :word, :type => :boolean, :aliases => '-w' , :desc => "word"
	option :line, :type => :boolean, :aliases => '-l' , :desc => "line"
	
	
	def wcex(file)
		byte = 0
		line = 0
		word = 0
		
		f = open(file)
		byte = file.size
		
		while tmp = f.gets
			line += 1
			word += tmp.split(" ").size
		end
		
		if options[:byte] then
				p "bytes = #{byte}"
			elsif options[:word] then
				p "words = #{word}"
			elsif options[:line] then
				p "lines = #{line}"
			else
				p "lines = #{line}  words = #{word} bytes = #{byte}"
		end
	end
end

Wcex.start(ARGV)