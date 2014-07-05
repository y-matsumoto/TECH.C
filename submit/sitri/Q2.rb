# 1
require 'Prime'

def aa
    Prime.each(100) do |a|
      p a
    end
end
aa


#2
require 'Date'

class BB
    def cc
        for b in 0..2014
            if Date.new(b).leap? 
                p b
            end
        end
    end
end
bb = BB.new()
bb.cc