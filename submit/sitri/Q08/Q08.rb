class Question
  attr :quest
	def initialize(num=10)
    @quest = (0...num+1).map{ ( 'a'..'z' ).to_a[rand(26)] }.join
  end
end

a = Question.new( rand(5..10) ) # 5～１０文字の、ランダムな文字列を生成
