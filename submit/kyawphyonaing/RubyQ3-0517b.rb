#
#  Q3.rb
#  
#
#  Created by kyawphyo on 5/24/26 H.
#  Copyright 26 Heisei __MyCompanyName__. All rights reserved.
#


class Num
    
    def initialize(number)
        @number = number
        @@arr = Array.new(@number){Array.new(@number)}
    end
    
    def magic
        
        
        y = @number/2
        x = @number -1
        
        @@arr[y][x] = 1
        
        ytmp = y
        xtmp = x
        
        for i in 2..@number*@number
            xtmp += 1
            ytmp -= 1
            
            xtmp -= @number if xtmp == @number
            ytmp += @number if ytmp == -1
            if @@arr[ytmp][xtmp] == nil
                @@arr[ytmp][xtmp] = i
                y = ytmp
                x = xtmp
                else
                x -= 1
                x += @number if x == -1
                ytmp = y
                xtmp = x
                @@arr[ytmp][xtmp] = i
            end
        end
        return @@arr
    end
    
    
    def putsArray
        for i in 0..@number-1
            for j in 0..@number-1
                print "[#{@@arr[i][j]}]"
            end
            puts
        end
    end
    
end

puts "please enter number"

number = gets.to_i

test = Num.new(number)
test.magic
test.putsArray