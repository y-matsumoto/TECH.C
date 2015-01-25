def tail(read_lineno, file_name)
  open(file_name){ |io|
  
    file_line_count = io.count
    
    io.seek(0, IO::SEEK_SET) # io.countでファイルポインタがEOFにあるので、ファイルの先頭に戻す。
    io.lineno = 0 # io.countでファイルの行数がはいっちゃってるので、初期化。
    
    # もし、ファイルの行数＜読み込む行数　ならば、読み込む行数＝ファイルの行数。
    read_lineno = file_line_count < read_lineno ? file_line_count : read_lineno
    
    io.each_line{ |line|
      if io.lineno >= file_line_count - read_lineno + 1 then
        p line
      end
    }
  }
end

tail($*[0].to_i, $*[1])