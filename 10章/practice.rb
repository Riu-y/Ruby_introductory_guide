#----- yieldとProcを理解する -----

・ブロックを利用するメソッドの定義とyield
・Procオブジェクト

# -- 10.2 ブロックを利用するメソッドの定義とyield--

#yieldwp使ってブロックの処理を呼び出す

def greeting 
	puts 'おはよう'
	puts 'こんばんは'
end

greeting
#=>おはよう
#=>こんばんは


#ブロック付きでgreetingメソッドを呼び出す
greeting do 
	puts 'こんにちは'
end
#=> おはよう
#=> こんばんは

def greeting
	puts 'おはよう'
	#ここでブロック処理を呼び出す
	yield
	puts 'こんばんは'
end

def greeting
	puts 'おはよう'
	yield
	yield
	puts 'こんばんは'
end

greeting do
	puts 'こんにちは'
end

#block_given?メソッドでブロックが渡されたかどうかを判断
def greeting
	puts 'おはよう'
	if block_given?
		yield
	end
	puts 'こんばんは'
end

greeting
#=>おはよう
#=>こんにちは
greeting do
	puts 'こんにちは'
end


def greeting
	puts 'おはよう'
	#ブロックに引数を渡し戻り値を受け取る
	text = yield 'こんにちは'
	#ブロックの戻り値をコンソールに出力する
	puts text
	puts 'こんばんは'
end

greeting do |text|
	#yeildで渡された文字列（"こんにちは”）を2回繰り返す
	text * 2
end

#ブロックを引数として明示的に受け取る
def メソッド(?引数)
	℃ブロックを実行する
	 引数.call
end

#ブロックをメソッドの引数として受け取る
def greeting(&block)
	puts 'おはよう'
	#callメソッドを使ってブロくを実行する
	text = block.call('こんにちは')
	puts text
	puts 'こんばんは'
end

greeting do |text|
	text * 2
end
# おはよう
# こんにちはこんにちは
# こんばんは

def greeting(&block)
	puts 'おはよう'
	#ブロックが渡されていなければblockはnil
	unless block.nil?
		text = block.call('こんにちは')
		puts text
	end
	puts 'こんばんは'
end

#ブロックなしで呼び出す
greeting
#=> おはよう
#=> こんばんは

#ブロック付で呼び出す
greeting do |text|
	text * 2
end
#=> おはよう
#=> こんにちはこんにちは
#=> こんばんは

## --- ブロックを引数として受け取ることのメリット ---
#ブロックを他のメソッドに渡すことができる

#日本語版のgreettingメソッド

def greeting_ja(&block)
	texts = ['おはよう','こんにちは','こんばんは']
	#ブロックを別のメソッドに引き渡す
	greeting_common(texts, &block)
end

#英語版のgreetingメソッド
def greeting_en(&block)
	texts = ['good morning', 'hello', 'good evening']
	#ブロックを別のメソッドへ引き渡す
	greeting_common(text, &block)
end

#出力処理用の共通用のメソッド
def greeting_common(texts, &block)
	puts texts[0]
	#ブロックを実行する。block callと定義することでブロックで定義した処理が行われる。
	puts block.call(texts, &block)
	puts texts[2]
end

greeting_ja do |text|
	text * 2
end

greeting_en do |text|
	text.upcase
end

#他のメソッドにブロックを引き渡す場合は引数の手前にも&をつける、＆を付けない場合はブロックではなく普通の引数の1つとみなされる。
#引数名の手前に&をつけると、ブロックとみなされる
greeting_common(texts, &block)

# &なしで呼び出すと普通の引数の1つとみなされる
greeting_common(texts, block)

#もう一つのメリットは渡されたブロックに対してメソッドを呼び出し、必要な情報を取得したりブロックに対する何かしらの操作を実行したりできる様にする

def greeting(&block)
	puts 'おはよう'
	text =
		if block.arity == 1
			#arityメソッドはブロック引数の個数を確認できる
			#ブロック引数が1個の場合
			yield 'こんにちは'
		elsif block.arity == 2
			#ブロック引数が2個の場合
			yield 'こんに','ちは'
		end
		puts text
		puts 'こんばんは'
	end

#1個のブロック引数でメソッドを呼び出す
greeting do |text|
	text * 2
end

#2個のブロック引数でメソッドを呼び出す
greeting do |text_1,text_2|
	text_1 * 2 + text_2 * 2
end


#---  10.3 Procオブジェクト ---

#Procオブジェクトの基礎

hello_proc = Proc.new do
	'Hello'
end

# do...endの代わりに{}を使っても良い
hello_proc = Proc.new {'Hello!'}

Procオブジェクトはオブジェクトとして存在しているだけでは全く実行されない。
Procオブジェクトを実行したい場合はcallメソッドを使う。

#Hello!という文字列を返すProcオブジェクトを作成する
hello_proc = Proc.new { 'Hello!' }
#Procオブジェクトを実行する
hello_proc.call #=> "Hello"

#実行時に引数を利用するProcオブジェクトも定義する。
add_proc = Proc.new {|a,b| a + b}
add_proc.call(10,20) #=> 30

add_proc = Proc.new { |a = 5,b = 5| a + b }
add_proc.call

#Proc.newの変わりにprocメソッドを使う
#Procオブジェクトを作成する場合はProc.newの代わりにKernelモジュールのprocメソッドを使うことができる
add_proc = proc {|a,b| a + b}

#Procオブジェクトをブロックの代わりに渡す
# Procオブジェクトはブロックと同じ様に処理の塊を表すがブロックとは異なり、オブジェクトとして扱うことができる
# 変数に入れて別のメソッドに渡したり、Procオブジェクトに対してメソッドを使うこともできる

def greeting(&block)
	puts 'おはよう'
	text = block.call('こんにちは')
	puts text
	puts 'こんばんは'
end

greeting do |text|
	text * 2
end

#Procオブジェクトを作成し、それをブロックの代わりとしてgreetingメソッドに渡す

def greeting(&block)
	puts 'おはよう'
	text = block.call('こんにちは')
	puts text
	puts 'こんばんは'
end
repeat_proc = Proc.new {|text| text * 2 }
greeting(&repeat_proc)
#必ず引数の前に＆をつけること


#Procオブジェクトを普通の引数として渡す

def greeting(arrange_proc)
	puts 'おはよう'
	text = arrange_proc.call('こんにちは')
	puts text
	puts 'こんばんは'
end

#Procオブジェクトを普通の引数としてgreetingメソッドに渡す
repeat_proc = Proc.new {|text| text * 2 }
greeting(repeat_proc)

#3種類のProcオブジェクトを受け取り、それぞれの挨拶文字列に適用するgreetingメソッド
def greeting(proc_1,proc_2,proc_3)
	puts proc_1.call('おはよう')
	puts proc_2.call('こんにちは')
	puts proc_3.call('こんばんは')
end

shuffle_proc = Proc.new { |text| text.chars.shuffle.join }
repeat_proc = Proc.new {|text| text * 2 }
question_proc = Proc.new {|text| "#{text}?" }

greeting(shuffle_proc,repeat_proc,question_proc)


def greeting(proc1,proc2,proc3)
	puts proc1.call('good morining')
	puts proc2.call('Hello')
	puts proc3.call('good evening')
end

shuffle_proc = Proc.new { |text| text.chars.shuffle.join }
adding_proc = Proc.new {|text| text + "John!" }
redefine_proc = Proc.new {|text| "Have a good day." }

greeting(shuffle_proc,adding_proc,redefine_proc)

#-- Proc.newとラムダの違い --

Proc.newまたはprocメソッドでProcオブジェクトを作成する
Proc.new {|a, b| a + b}
proc {|a, b| a + b}
->(a,b) { a + b }
lambda {|a, b| a + b }

# ->を使うラムダリテラル（アロー演算子呼ばれる）後ろにくる()は引数のリストで省略も可能
-> a, b { a + b }
#引数がなければ全て省略できる
-> { 'Hello' }
#ブロックを作成する時と同様、{}は改行させても問題ない
->(a,b){
	a + b
}
#また{}の代わりに、 do...endも使える
->(a,b) do
	a + b
end
#Proc.newと同じ様に引数のデフォルト値を持たせることも可能
->(a = 0, b = 0) { a + b }

#Proc.newの作成と実行
add_proc = Proc.new {|a,b| a + b}
add_proc.call(10, 20) #=> 30

#ラムダの作成と実行
add_lambda = ->(a, b){ a + b }
add_lambda.call(10,20) #=>30

#ラムダの方が引数のチェックが厳密になる

#Proc.newの場合（引数がエラーにならない様にto_sメソッドを使う）
add_proc = Proc.new {|a, b| a.to_i + b.to_i }
add_proc(10)#=>10
add_proc(10,20,100) #=>30

#ラムダの場合
add_lambda = ->(a, b) { a.to_i + b.to_i }
#ラムダは個数について厳密なので、引数がちょうど2つでないとエラーになる
add_lambda.call(10) #=>#=> ArgumentError: wrong number of arguments (given 1, expected 2)
add_lambda.call(10,20,30) #=> ArgumentError: wrong number of arguments (given 3, expected 2)

#Proc.newからむだか判断するlambda?メソッド
add_proc = Proc.new
add_proc.class #=>Proc
add_proc.lammbda? #=>Error

add_lambda = -> (a, b) { a + b }
add_lambda.class #=> Proc
add_lambda.lambda? #=>true

#メソッドチェーンを使ってコードを書く

def self.loud(level)
	->(words) do
		words.split(' ').map { |word| word.upcase + '!' * level }.join(' ')
	end
end

def self.loud(level)
	->(words) do
		words
		.split('')
		.map{ |word| word.upcase + '!' * level }
		.join(' ')
	end
end





