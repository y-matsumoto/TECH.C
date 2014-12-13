require './Deck.rb'
require './Hand.rb'

#　カードの種類
# n/13して、 0: スペード, 1: クローバ, 2: ダイヤ, 3: ハート, 4: ジョーカ
# n%13して、 +1したのが、カードの数値。ジョーカなら、連番みたいな感じ。


deck = Deck.new(0)
p deck