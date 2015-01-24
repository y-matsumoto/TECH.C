def wc(file_name)
  open(file_name){ |io|
    words = 0
    io.each_line{ |line|
      words += line.split("\s").count
    }
    p "words: #{words}"
    p "size: #{io.size}"
    p "lineno: #{io.lineno}"
  }
end


#$*.each { |file_name| wc(file_name) }
