#
#  RubyQ4-0524.rb
#  
#
#  Created by kyawphyo on 5/24/26 H.
#  Copyright 26 Heisei __MyCompanyName__. All rights reserved.
#

def make_answer
	list = (0..9).to_a
	(0..2).map{ list.delete_at( rand(list.size-1)) }
end

def check(user,answer)
	hit = user.zip(answer).inject(0){|i,(u,a)| u == a ? (i+1) : i}
	blow = user.inject(0){|i,u| (answer.include? u) ? (i+1) : i} - hit
	[hit, blow]
end


answer =  make_answer
p answer
p "== Hit and Blow =="
p "Please enter number (3-digit)"

try_times =0

loop{
	try_times +=1
	printf("try %d ::",try_times)
	user = $stdin.gets.chomp!.unpack("a1a1a1a1").collect{|i| i.to_i}
	hit , blow = check(user,answer)
	if hit == 3
		puts "You win!"
        break
        else
		puts "   hit:#{hit}  blow:#{blow}"
	end
}
