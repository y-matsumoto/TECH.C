#!/usr/bin/env ruby
# encoding utf-8

require 'thor'

class WCEX2 < Thor
  desc 'wcex','show lines words bytes'
  option :full, :type => :boolean, :aliases => '-f', :desc => "show all"
  option :word, :type => :boolean, :aliases => '-w', :desc => "show words"
  option :byte, :type => :boolean, :aliases => '-c', :desc => "show bytes"
  option :line, :type => :boolean, :aliases => '-l', :desc => "show lines"
  def wcex(name)
    #ファイルオープン
	file = File::open(name,"r")
	
	#変数宣言
    lines = 0
    words = 0
    bytes = file.size
	
	if options[:word] then
		while line = file.gets
		  wordArray = line.split(",").reject{|w| w.empty?}
		  words += wordArray.length
		end
		p "words:#{words}"
	elsif options[:byte] then
		p file.size
	elsif options[:line] then
		while line = file.gets
			lines += 1
		end
		p "lines:#{lines}"
    else
		while line = file.gets
			lines += 1
			wordArray = line.split(",").reject{|w| w.empty?}
			words += wordArray.length
		end
		p "lines:#{lines} words:#{words} bytes:#{bytes}"
	end
  end
end

WCEX2.start(ARGV)