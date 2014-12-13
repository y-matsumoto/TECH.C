def filemg
    #ファイルオープン
    #第1引数,ファイル名、第2引数,モード
    file = File::open("sample.txt","r");
    #行数、単語数、文字数
    lines = 0;
    words = 0;
    chars = 0;

    #数える
    #getsメソッドで1行ずつ読み込む（EOFに到達すると終了する）
    while line = file.gets
      #行
      lines += 1
      #単語
      wordArray = line.split(",").reject{|w| w.empty?}
      words += wordArray.length
      #文字
      chars += line.length;
    end
    #表示
    puts "lines=#{lines} words=#{words} chars=#{chars}"
end
filemg