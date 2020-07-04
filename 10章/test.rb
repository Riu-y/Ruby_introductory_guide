# def greeting
# 	puts 'おはよう'
# 	yield
# 	yield
# 	puts 'こんばんは'
# end

# greeting do
# 	puts 'こんにちは'
# end

# def greeting
# 	puts 'おはよう'
# 	if block_given?
# 		yield
# 	end
# 	puts 'こんばんは'
# end

# greeting
# #=>おはよう
# #=>こんばんは
# greeting do
# 	puts 'こんにちは'
# end
# # おはよう
# # こんにちは
# # こんばんは

# def greeting
# 	puts 'おはよう'
# 	#ブロックに引数を渡し戻り値を受け取る
# 	text = yield 'こんにちは'
# 	#ブロックの戻り値をコンソールに出力する
# 	puts text
# 	puts 'こんばんは'
# end

# greeting do |text|
# 	#yeildで渡された文字列（"こんにちは”）を2回繰り返す
# 	text * 2
# end


#ブロックをメソッドの引数として受け取る
# def greeting(&block)
# 	puts 'おはよう'
# 	#callメソッドを使ってブロくを実行する
# 	text = block.call('こんにちは')
# 	puts text
# 	puts 'こんばんは'
# end

# greeting do |text|
# 	text * 2
# end

# def greeting(&block)
# 	puts 'おはよう'
# 	#ブロックが渡されていなければblockはnil
# 	unless block.nil?
# 		text = block.call('こんにちは')
# 		puts text
# 	end
# 	puts 'こんばんは'
# end

# #ブロックなしで呼び出す
# greeting
# #=> おはよう
# #=> こんばんは

# #ブロック付で呼び出す
# greeting do |text|
# 	text * 2
# end

# def greeting_ja(&block)
# 	texts = ['おはよう','こんにちは','こんばんは']
# 	#ブロックを別のメソッドに引き渡す
# 	greeting_common(texts, &block)
# end

# #英語版のgreetingメソッド
# def greeting_en(&block)
# 	texts = ['good morning', 'hello', 'good evening']
# 	#ブロックを別のメソッドへ引き渡す
# 	greeting_common(texts, &block)
# end

# #出力処理用の共通用のメソッド
# def greeting_common(texts, &block)
# 	puts texts[0]
# 	#ブロックを実行する
# 	puts block.call(texts[1])
# 	puts block.call(texts[2])
# end

# greeting_ja do |text|
# 	text * 2
# end

# greeting_en do |text|
# 	text.upcase
# end

# def greeting(&block)
# 	puts 'おはよう'
# 	text =
# 		if block.arity == 1
# 			#arityメソッドはブロック引数の個数を確認できる
# 			#ブロック引数が1個の場合
# 			yield 'こんにちは'
# 		elsif block.arity == 2
# 			#ブロック引数が2個の場合
# 			yield 'こんに','ちは'
# 		end
# 		puts text
# 		puts 'こんばんは'
# 	end

# #1個のブロック引数でメソッドを呼び出す
# greeting do |text|
# 	text * 2
# end
# # おはよう
# # こんにちはこんにちは
# # こんばんは

# #2個のブロック引数でメソッドを呼び出す
# greeting do |text_1,text_2|
# 	text_1 * 2 + text_2 * 2
# end
# # おはよう
# # こんにこんにちはちは
# # # こんばんは

# add_proc_1 = Proc.new {'Hello'}
# p add_proc_1.call

# add_proc = Proc.new {|a,b| a + b}
# p add_proc.call(10,50)

# # add_proc = Proc.new { |a = 5,b = 5| a + b }
# # p add_proc.call
# # p add_proc.call(10)
# # p add_proc.call(10,20)


# def greeting(&block)
# 	puts 'おはよう'
# 	text = block.call('こんにちは')
# 	puts text
# 	puts 'こんばんは'
# end
# repeat_proc = Proc.new {|text| text * 2 }
# greeting(&repeat_proc)

# def greeting(arrange_proc)
# 	puts 'おはよう'
# 	text = arrange_proc.call('こんにちは')
# 	puts text
# 	puts 'こんばんは'
# end

# #Procオブジェクトを普通の引数としてgreetingメソッドに渡す
# repeat_proc = Proc.new {|text| text * 2 }
# greeting(repeat_proc)

#3種類のProcオブジェクトを受け取り、それぞれの挨拶文字列に適用するgreetingメソッド
def greeting(proc_1,proc_2,proc_3)
	puts proc_1.call('おはよう')
	puts proc_2.call('こんにちは')
	puts proc_3.call('こんばんは')
end

shuffle_proc = Proc.new { |text| text.chars.shuffle.join }
repeat_proc = Proc.new {|text| text * 2 }
question_proc = Proc.new {|text| "#{text}?" }

p greeting(shuffle_proc,repeat_proc,question_proc)

def greeting(proc1,proc2,proc3)
	puts proc1.call('good morining')
	puts proc2.call('Hello')
	puts proc3.call('good evening')
end

shuffle_proc = Proc.new { |text| text.chars.shuffle.join }
adding_proc = Proc.new {|text| text + "John!" }
redefine_proc = Proc.new {|text| "Have a good day." }

p greeting(shuffle_proc,adding_proc,redefine_proc)