#----- モジュールを理解する------

deep_freezeメソッド

#Rubyの場合、ミュータブルなオブジェクトを定数にっ設定した場合は、そのオブジェクトを凍結しないと破壊的な変更ができてしまう

class Team
	#配列をfreezeして要素の追加や削除を禁止する
	COUNTRIES = ['japan','US','India'].freeze
end

#しかし配列やハッシュの場合、配列の内部の要素もfreezeしないと要素の値が変更される恐れがある
def Team
	#思いがけない事故を防ぐため配列の要素もfreezeする
	COUNTRIES = ['japan'.freeze,'US'.freeze,'Indea'.freeze].freeze
end

#上記の様に毎回freezeを記述するのは面倒なのでdeep_freezeというメソッドを作成し、配列や播種地震と内部の全要素をfreezeできる様にする
#flozen?メソッドはオブジェクトがfreezeされていたらtrueを返すメソッドでall?メソッドはブロックが全てtrueを返した場合にtrueを返す繰り返し用のメソッド
class Team
	COUNTRIES = deep_freeze(['japan','US','India'])
end

#配列自身と配列の全要素がfreezeされている
Team::COUNTRIES.frozen? #=>true
Team::COUNTRIES.all? { |country| country.frozen? } #=>true

class Bank
	CURRENCIES = deep_freeze({ 'japan' => 'yen,' 'US' => 'dollar', 'India' => 'rupee' })
end

#ハッシュ自身とハッシュの全要素(キーと値)がfreezeされている
Bank::CURRENCIES.frozen? #=> true

Bank::CURRENCIES.all?{|key, value| key.frozen? && value.frozen? } #=>true
#TeamクラスとBankクラスという全く別のクラスでdeep_freezeメソッドを呼び出している

# --8.2 モジュールの概要 --

#モジュールの主な用途
# 継承を使わずにクラスにインスタントメソッドを追加する、もしくは上書きする（ミックスイン）
# 複数のクラスに対して共通の特異メソッド（クラスメソッド）を追加する（ミックスイン）
# クラス名や定数名の衝突を防ぐために名前空間を作る
# 関数的メソッドを定義する
# シングルトンオブジェクトの様に扱って設定値などを保持する

#ジュールの定義

# module モジュール名
# 	モジュールの定義（メソッドや定数など）
# end

#helloメソッドを持つgreeterモジュールを定義
module Greeter
	def hello
		'hello'
	end
end

モジュールからインスタンスを作成することはできない
他のモジュールやクラスを継承することはできない

#モジュールのインスタンスは作成できない
greeter = Greeter.new #=> NoMethodError

#他のモジュールから継承して新しいモジュールは作れない
module Awesome < Greeter
end #=>SyntaxError

#-- 8.3 モジュールのミックスイン --

#モジュールのクラスにincludeする
#Rubyは単一継承を採用しているので1つのクラスは1つのスーパークラスしかもてない。
しかしis_aの関係になくても複数のクラスにまたがって同じ様な機能が必要になるケースが存在する。
class Product
	def title
		log 'title is called'
		'A great movie'
	end

	private

	def log(text)
		puts "[LOG]#{text}"
	end
end

class User 
	def name
		log 'name is called'
		'Alice'
	end

	private

	#このメソッドの実装はProductクラスのlogメソッドと全く同じ
	def log(text)
		puts "[LOG]#{text}"
	end
end
product = Product.new
product.title
#=> [LOG]title is called
# "Alice"

user = User.new
user.name
#=> [LOG]name is called
# "Alice"

#ログを出力する処理は重複しているが、コードが重複しているからと言って安易に継承を使うべきではない
#軽症は使えないが共通の処理は持たせたいときにモジュールをを使うと良い

#ログ出リョ奥用のメソッドを提供するモジュール
module Loggable
	def log(text)
		puts "[LOG]#{text}"
	end
end

class Product
	#上で作ったモジュールをincludeする
	include Loggable

	def title
		#logメソッドはLoggaableモジュールで定義したメソッド
		log 'title is called.'
		'A great movie'
	end
end

class User
	include Loggable

	def name
		log 'name is called.'
		'Alice'
	end
end

product = Prodct.new
product.title
#=> [LOG]title is called.
#=>"A great movie"

user = User.new
user.name
#=>[LOG]name is called.
#=>"Alice"

product.log 'public?' #=> [LOG public]

#モジュールのlogメソッドをpublicメソッドにする必要がなければモジュール側でprivate定義をできる

module Loggable
	#logメソッドはprivateメソッドにする
	private

	def log(text)
		puts "[LOG] #{text}"
	end
end

class Product
	include Loggable
	#省略
end

#log メソッドはprivateメソッドなので外部から呼び出せない
product.log 'public?'
#=>NoMethodError

#-- モジュールをextendする --


#モジュールをクラスにミックスインするもう一つの方法としてextendがある。
#extendを使うとモジュールないのメソッドをそのクラスの特異メソッドにすることができる

#モジュールの定義はincludeするときと同じ
module Loggable
	def log(text)
	end
end

class Product
	#Loggableモジュールのメソッドを特異メソッドとしてミックスインする
	extend Loggaable

	def self.create_products(names)
		#logメソッドをクラスメソッド内で呼び出す
		#つまりlogメソッド自体もクラスメソッドになっている
		log 'create_products is called'
	end
end

#クラスメソッド経由でlogメソッドが呼び出される
Product.create_products([])

#Productクラスのクラスメソッドとして直接呼び出すことも可能
Product.log('Hello')

#deep_freezeメソッドの作成

module DeepFreezable
 def deep_freeze(array_or_hash)
 end
end

class Team
	extend DeepFreezable

	COUNTRIES =deep_freeze(['japan','US','India'])
end

class Bank
	extend DeepFreezable

	COUNTRIES =deep_freeze({ 'japan' => 'yen' , 'US' => 'dollar' , 'India' => 'rupee' })
end

#ハッシュのキーが文字列の場合は自動的にfreezeされる

#文字列をキーにすると、自動的にキーがfreezeされる
country = 'US'
hash = { 'Japan'=> 'yen' , 'country' => 'dollar' }
hash.keys[0].frozen? #=> true
hash.keys[1].frozen? #=> true


# -- 8.5 ミックスインについてもっと詳しく
#includeされたモジュールの有無を確認する

module Loggable
end

class Product
	include Loggable
end

Product.include?(Loggable) #=>true
#include_modulesメソッドを呼び出すとincludeされているモジュールの配列が返る
Product.include_modules #=> [Loggable,kernel]
#ancestorsメソドオを使うとモジュールだけでなくスーパークラスの情報も配列になって返ってくる
Product.ancestors #=> [Product,Loggable, kernel,BasicObject]
クラスオブジェクトではなく,クラスのインスタンスからもincludeされているモジュールの情報は取得できる
product = Product.new
product.class.include?(Loggable) #=>true
product.class.include_modules #=>[Loogable,Kernel]
#classメソッドを使うと自分が属しているクラスのクラスオブジェクトが取得できるため

#is_a?メソッドを使えば直接インスタンスに対してそのモジュールをincludeしているかどうかがわかる
product = Product.new
product.is_a?(Product)
product.is_a?(Loggable)
product.is_a?(Object)

#include先のメソッドを使うモジュール
module Taggable
	def price_tag
		#priceメソッドはinclude先で定義されている前提
		"#{price}円"
		#"#{self.price}"self付きでメソッドを呼び出しても構わない
	end
end

class Product
	include Taggable

	def price
		1000
	end
end

product = Product.new
product.price_tag #=> "1000円"

#Enumerableモジュール
Enumerableモジュールは配列やハッシュ、範囲（Range）など何かしらの繰り返し処理ができるクラスにincludeされているモジュール。
以下の様にクラスに対してissnclude?メソッドを呼び出すとわかる
Array.include?(Enumerable) #=> true
Hash.include?(Enumerable) #=>true
Rnage.include?(Enumerable) #=> true

#配列、ハッシュ、範囲でmapメソッドを使う
[1,2,3].map { |n| n * 10 }
{ a: 1, b: 2 , c: 3 }.map{|k,v|[k, v * 10]}
(1..3).map{ |n| n * 10 }

#配列、ハッシュ、範囲でcountメソッドを使う
[1,2,3].count #=>3
{ a: 1, b: 2, c: 3}.count #=>3
(1..3).count #=>3

#-- Enumurableモジュールのいろいろ --

# -- all? --
#全ての要素がブロック内部の条件を満たしているとtrueを返す
[1,2,3].all?{ |v| V > 0 }
#=> true
[1,2,3].all?{ |v| v < 1 }
#=>false

#上記をeachで書くと
flg = true
(1..3).each do |v|
	if v <= 0
		flg = false
		break
	end
end

#-- any? --
# 要素のいずれかがブロック内部の条件を満たせばtrueを返す
[1,2,3].any? { |v| v == 2}
#=> true

#上記をeachでかくと
flg = false
(1..3).each do |v|
	if v == 2
		flg = true
		break
	end
end
p flg #=>true

#-- collectとmap --
#各項を2倍にした配列を返す
[1,2,3].collect{ |v|  v * 2 }
#=>[2,4,6]
[1,2,3].map { |v| v * 2 }
#=>[2,4,6]

#上記をeachで書くと
num = []
[1,2,3].each do |n|
	num << n * 2
end
p num

#-- collect_concat,flap_map --

#各項を2倍にした配列を返す
[[1,2],[3,4]].flat_map { |v| v.map {|cv| cv * 2} }
#=>[2,4,6,8]

#eachで書くと
num = []
[[1,2],[3,4]].each do |n|
	num << n * 2
end
p num

#-- detect, find --
[1,3,7].detect {|v| (3..5).include?(v)}









