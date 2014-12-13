def tail(num,fileName)
  maxLine = File.read(fileName).count("\n")
  
  # モード省略は"r"で開かれる
  open(fileName) {|file|
    if maxLine - num <= 0
      num = 1
    end
    # 末尾から指定数の位置読み込み（最大行数 - 指定行数 = 末尾からの指定行数）
    puts file.readlines[maxLine - num]
  }
end

def integer_string?(str)
  Integer(str)
  true
rescue ArgumentError
  false
end

# コマンドライン引数があれば
# 引数がどちらとも入力されているか
if nil != ARGV[0] && nil != ARGV[1]

  # 数値にできるか
  if !integer_string?(ARGV[0])
    puts "数値を入力してください"
    return ;
  end

  # 拡張子がtxtならば
  if File.extname(ARGV[1]) == ".txt"
    tail(Integer(ARGV[0]),ARGV[1])
  else
    puts "拡張子をtxtにしてください"
  end
else
  puts "引数は[行数][ファイル名.txt]で指定してください"
end