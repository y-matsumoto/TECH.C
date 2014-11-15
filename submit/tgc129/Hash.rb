class Hash
  
  def initialize()
    @wday = {"Sunday" => "日曜日",
            "Monday" => "月曜日",
            "Tuesday" => "火曜日",
            "Wednessday" => "水曜日",
            "Thursday" => "木曜日",
            "Friday" => "金曜日",
            "Saturday" => "土曜日"
    }
  end
  
  def len
    p @wday.length
  end
  
  def roop
    @wday.each{|key, value|
      print("[" + key + "]" + "は日本語で" + value + "です。\n")
    }
  end
end

hash = Hash.new
hash.len
hash.roop