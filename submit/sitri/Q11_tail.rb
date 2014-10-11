def tail(file_name)
  open(file_name){ |io|
    #とりあえず全部読み込んで、行数だけ取得
    io.each_line{} #　最終行に
    p io.lineno
    
    io.seek(0, IO::SEEK_SET) # ファイルポインタをファイルの先頭に移動
    
  }
end
$*.each { |file_name| tail(file_name) }