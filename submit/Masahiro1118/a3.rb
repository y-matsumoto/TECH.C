#右1　上1 ただしぶつかったら戻って左１

#---
#--1

class MagicSquare

  def initialize
     @square = Array.new(3,0).map{Array.new(3,0)}
     @square[1][2] = 1

     @nowPosition = Array.new(1)
     @nowPosition = [1,2]
  end
  def view_magic_square
      p @square
  end

  def move_and_push
    now = @square[@nowPosition[0]][@nowPosition[1]]
    nextNum = now + 1

    nextX = (@nowPosition[1]) +1
    nextY = (@nowPosition[0]) -1

    if(3 == nextX) then
      nextX = 0
    elsif(nextX < 0) 
      nextX = 2
    end

    if(3 == nextY) then
      nextY = 0
    elsif(nextY < 0)
      nextY = 2
    end

    if @square[nextY][nextX] == 0 then
      @nowPosition = [nextY,nextX]
      @square[nextY][nextX] = nextNum
    else
      nextX = @nowPosition[1] - 1
      nextY = @nowPosition[0] 
      @nowPosition = [nextY,nextX]
      @square[nextY][nextX] = nextNum
    end
    
  end

end

t = MagicSquare.new
t.move_and_push
t.view_magic_square
t.move_and_push
t.view_magic_square
t.move_and_push
t.view_magic_square
t.move_and_push
t.view_magic_square
t.move_and_push
t.view_magic_square
t.move_and_push
t.view_magic_square
t.move_and_push
t.view_magic_square
t.move_and_push
t.view_magic_square