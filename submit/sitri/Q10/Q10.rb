# 再起とかめんどいので、Array クラスをそのまま拡張する感じで。

class Array
  def quickSort
    return self if self.length <= 1
    p = pop
    i, j = partition { |e|
      e < p
    }
    push p
    i.quickSort + [p] + j.quickSort
  end
end

a = (1...10000).to_a.shuffle
p '***** before sort ***** ' , a
p '***** after sort ***** ' , a