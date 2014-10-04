class Stringarray

  def initialize
  @sarray = Array["Ruby","it","is","a","test","string","of",
                "study","for","the","array"]
  end 

  def sArray
    p @sarray
  end

  def sort
    p @sarray.sort{|a,b| a.downcase <=> b.downcase}
  end

  def big
    @sarray.each{|s| p s.capitalize}
  end
end

sa = Stringarray.new
sa.sArray
sa.sort
sa.big