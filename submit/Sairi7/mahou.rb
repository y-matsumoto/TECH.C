class Magic
	attr_accessor :size
	def initialize(size)
		@size = size
		@@mahou = Array.new(@size){Array.new(@size,0)}
	end
	
	def handan
		row = @size/2
		col = @size-1
		@@mahou[row][col] = 1

		for i in 2..(@size * @size) do
			row=row-1
			col=col+1

			if col >= @size && row >= 0 then		
				col = col - @size

			elsif row < 0 && col < @size then
				row = @size - 1

			elsif row < 0 && col >= @size then
				row = row + 1
				col = col - 2

			elsif @@mahou[row][col] != 0 then
				row = row+1
				col = col-2

			else
				col = col
				row=row

			end

			@@mahou[row][col] = i
		end
	cnt = 0
	@@mahou.each do |i|
		p i
		cnt += 1
			if cnt == @size
			p 
			cnt = 0
			end
	end
	return @@mahou
	end
end

magic = Magic.new(3)
magic.handan