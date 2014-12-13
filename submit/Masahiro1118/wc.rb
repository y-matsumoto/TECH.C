def wc(fileName)
  lines = words = chars = 0

  # モード省略は"r"で開かれる
  open(fileName){|file|
    # 行と単語数
    while line = file.gets
      lines += 1
      words += line.split("\s").size
    end
    # 全体の文字数には空白や改行も含まれているのでとりあえず
    # 全体サイズ - 単語の数（空白で分けているのでこの数だけ減らせばよい） + 1（ただし最後の改行は無視なので+1する）
    chars = file.size - (words + 1 )
  }

  # 行数、単語数、文字数
  puts "lines=#{lines} words=#{words} chars=#{chars}"
end

# コマンドライン引数があれば
# 複数引数は考慮しない
if nil != ARGV[0]
  # 拡張子がtxtならば
  if File.extname(ARGV[0]) == ".txt"
    wc(ARGV[0])
  else
    puts "拡張子をtxtにしてください"
  end
else
  puts "引数にファイルの名前を指定してください"
end