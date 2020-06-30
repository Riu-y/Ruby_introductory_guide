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
[1,3,7].detect {|v| (3..5).include?(v) }
#=>3

[1,3,7].find { |v| (3..5).include?(v) }
#=> 3

#eachで書く場合
num = []
[1,3,7].each do |n|
	if (3..5).include?(n)
		num << n
	end
end
p num


# -- Comparable モジュールと<=>演算子

# < <= == > >= between?
# Comparableモジュールのメソッドを使える様にするための条件はincludeさきのクラスで<=>演算子を実装しておくこと

# ・aがbより大きいなら正の整数
# ・aとbが等しいなら0
# ・aがbより小さいなら負の整数
# ・aとbが比較できない場合はnil

2 <=> 1 #=>1
2 <=> 2 #=> 0
1 <=> 2 #=>-1
2 <=> 'abc' #=>nil

'xyz' <=> 'abc' #=> 1
'abc' <=> 'abc' #=> 0
'abc' <=> 'xyz' #=>-1
'abc' <=> 123 #=> nil

class Tempo
	include Comparable
	attr_reader :bpm

	def initialize(bpm)
		@bpm = bpm
	end

	# <=>はComparableモジュールで使われる演算子
	def <=>(other)
		if other.is_a?(Tempo)
			#bpm同士を<=>で比較した結果を返す
			bpm <=> other.bpm
		else
			nil
		end
	end

	def inspect
		"#{bpm}bpm"
	end
end

p t_120 = Tempo.new(120) #=> 120bpm
p t_180 = Tempo.new(180) #=> 180bpm

p t_120 > t_180
p t_120 <= t_180
p t_120 == t_180

tempos = [Tempo.new(180),Tempo.new(60),Tempo.new(120)]
#sortメソッドの内部では並び替えの際に<=>演算子が使われる
p tempos.sort

# -- Kernelモジュール --
#puts p print require loop

KernelモジュールはObjectクラスがKernelモジュールをincludeしているから使える
Object.include?(Kernel) #=> true

# -- トップレベルはmailという名前のObject --

#クラスやモジュール自身もオブジェクト
class User
	p self #=>User
	p self.class #=>Class
end

p User.class #=> Class

p Class.superclass #=> Module

module Loggable
	p self #=> Logaable
	p self.class #=> Module
end

#-- 8.5 モジュールとインスタンス変数 --
module NamaChanger
	def change_name
		# include先ののクラスのインスタンス変数を変更する
		@name = 'アリス'
	end
end

class User
	include NameChanger

	attr_reader :name

	def initialize(name)
		@name = name
	end
end
user = User.new('Alice')
user.name #=> "アリス"

 ##モジュールとミックスイン先のクラスでインスタンス変数を共有するのはあまり良い設計ではない。インスタンス変数は未定義の状態でも自由に代入したり参照したりできるから
 #一方、メソッドであれば、未定義のメソッドを呼び出したときにエラーが発生する。なのでミックスイン先のクラスと連携する場合は、特定のインスタンス変数の存在を前提とするより特定のメソッドのの存在を前提とする方が安全。

 module NameChanger
 	def change_name
 		#セッターメソッド経由でデータを変更する
 		self.name
 	end
 end

class User
	include NameChanger

	attr_accessor :name

	def initialize(name)
		@name = name
	end
end


#オブジェクトに直接ミックスインする
module Loggable
	def log(text)
		puts "[LOG]#{text}"
	end
end

s = 'abc'

#文字列は通常logメソッドを持たない
s.log('Hello') #=> Error

#文字列sにLoggableモジュールのメソッドを特異メソッドとしてミックスインする
s.extend(Loggable)

s.log('Hello') #=> [LOG]Hello.]

#-- モジュールを利用した名前空間 --

class Second
	def initialize(player, uniform_number)
		@player = player
		@uniform_number = uniform_number
	end
end

class Second
	def initialize(digits)
		@digits = digits
	end
end

#大規模な開発で、クラス名が重なってしまった
Second.new('Alice',13)
Second.new(13)

#この様な場合に「名前空間(namespase)」としてモジュールを使う。モジュール構文の中にクラス定義を書くとそのモジュールに属するクラスという意味になるので名前の衝突がなくなる

module Baseball
	class Second
		def initialize(plasyer, uniform_number)
			@player = player
			@uniform_number = uniform_number
		end
	end
end
Baseball::Second.new('Alice',13)

module Clock
	class Second
		def initialize(digits)
			@digits = digits
		end
	end
end
Clock::Second.new(13)

#名前空間でグループやカテゴリを分ける

#ネストなしで名前空間つきのクラスを定義する
#名前空間として使うモジュールが既にどこかで定義されている場合はモジュール構文やクラス構文をネストさせなくても"モジュール名::クラス名"の様な形でクラスを定義することができる

module Baseball
end

#モジュール名::クラス名の形でクラスを定義できる
class Baseball::Second
	def initialize(player,uniform_number)
		@player = player
		@uniform_number = uniform_number
	end
end

#トップレベルの同名クラスを参照する
class Second
	def initialize(player,uniform_number)
		@player =player
		@uniform_number =uniform_number
	end
end

module Clock
	class Second
		def initialize(digits)
			@digits = digits
		end
	end
end

#この状態でclockモジュールのモジュールのSecondクラスがトップレベルのSecondクラスを参照したいというケース
module Clock
	class Second
		def initialize(digits)
			@digits = digits
			@baseball_second = ::Second.new('Clock',10)
			#クラス名の前に ::をつけるとトップレベルのクラスを指定したことになる
		end
	end
end

# -- 8.7 関数や定数を提供するモジュールの作成 --

#モジュールに特異メソッドを定義する

#わざわざ他のクラスに組み込まなくてもモジュール単体でそのメソッドを呼び出したいと思うケースがある。その場合はモジュール自身に特異メソッドを定義すれば直接モジュール名.メソッド名という形でそのメソッドを呼び出すことがで切る
module Loggable
	#特異メソッドとしてメソッドを定義する
	def self.log(text)
		puts "[LOG]#{text}"
	end
end

#他のクラスにミックスインしなくてもモジュール単体でそのメソッドを呼び出せる
Loggable.log('Hello') #=> [LOG]Hello

#モジュールはクラスと違ってインスタンスが作れないためnewする必要が全くない「単なるメソッドの集まりを作りたい」ケースに向いている
module Loggaable
	class << self
		def log(text)
			puts "[LOG]#{text}"
		end
		#他の特異メソッドを定義
	end
end

#module_functionメソッド
#ミックスインとしても使えて、尚且つ特異メソッドとしても使える一石二鳥なメソッド。

module Loggable
	def log(text)
		puts "[LOG]#{text}"
	end
	module_function :log
end

#モジュールの特異メソッドとしてlogメソッドを呼び出す
Loggable.log('Hello')

#Loggableモジュールをincludeしたクラスを定義する
class Product
	include Loggable

	def title
		# includeしたLoggableモジュールのlogメソッドを呼び出す
		log 'title is called.'
		'A great movie'
	end
end

ミックスインとしてlogメソッドを呼び出す
product = Product.new
product.title

#ミックスインとしてもモジュールの特異メソッドとしても使えるメソッドをモジュール関数という
#またmodule_functionでモジュール関数となったメソッドは自動的にprivateメソッドになる

#modele_functionメソッドを引数なしで呼び出した場合はそこから下に定義されたメソッド全てがモジュール関数になる
module Loggable
	#ここからしたのメソッドは全てモジュール関数
	module_function

	def log(text)
		puts "[LOG#{text}"
	end
end

#モジュールに定数を定義する
module Loggable
	#定数を定義する
	PREFIX = '[LOG]'.freeze

	def log(text)
		puts "#{PREFIX} #{text}"
	end
end
#--定数を参照する --
Loggable::PREFIX #=> "[LOG]"

#-- モジュール関数や定数を持つモジュールの例 --

#モジュールの特異メソッドとしてsqrt(平方根)メソッドを利用する
Math.sqrt(2) 

class Calculator
	include Math

	def calc_sqrt(n)
		#ミックスインとしてMathモジュールのsqrtメソッドを使う
		sqrt(n)
	end
end

calculator = Calculator.new
calculator.calc_sqrt(2)

p Math::E #自然対数の底
p Math::PI #円周率

# 状態を保持するモジュールの作成


module AwesomeApi
	#設定値を保持するインスタンス変数を用意する
	@base_url = ''
	@debag_mode = false

	#クラスインスタンス変数を読み書きするための特異メソッドを定義する
	class << self
		def base_url=(value)
			@base_url = value
		end

		def base_url
			@base_url
		end

		def debug_mode=(value)
			@debug_mode = value
		end

		def debug_mode
			@debug_mode
		end
		#本来は以下の1行ですむ
		#attr_accessor :base_url, :debug_mode
	end
end
#設定値を保存する
Awesome.base_url = 'http://example.com'
AwesomeApi.debug_mode = true

#設定値を参照する
p Awesome.base_url
p AwesomeApi.debug_mode

require 'singleton'

class Configuration
	#Singletonモジュールをincludeする
	include Singleton

	attr_accessor :base_url, :debug_mode

	def initialize
		#設定値を初期化
		@base_url = ''
		@debug_mode = false
	end
end
#Configurationクラスはnewできない
config = Configuration.new #=> Error

#instanceメソッドを使ってインスタンスを取得する
config = Configuration.instance
#設定値を設定する
config.base_url = 'http://example.com'
config.debug_mode = true

#instanceメソッドを使って再度インスタンスを取得する
other = Configuration.instance
other.base_url #=> "http://example.com"
other.debug_mode #=>true

#どちらも全く同じオブジェクト（インスタンス）になっている
config.object_id #70147234819160
other.object_id #70147234819160

#モジュールの用途は1つとは限らない

#あるモジュールが設定値情報を保持しつつ、名前空間を提供に使用さることもある

#AwesomeApiモジュールは設定値を保持する(用途1)
module AwesomeApi
	@base_url = ''
	@debug_mode = false

	class << self
		attr_accesor :base_url, :debug_mode
	end
end
#こちらでは名前空間として使われる（用途その2）
module AwesomeApi
	class Engine
		#クラスの定義
	end
end

# -- 8.9 モジュールに関する高度な話題 --
#メソッド探索のルールを理解する

#Rubyには様々なメソッドの定義方法がある。例えばto_sメソッドを呼び出すにも

# そのクラス自身にto_sメソッドが定義されている場合
# そのスーパークラスにto_sメソッドが定義されている場合
# ミックスインとしてto_sメソッドが定義(inclede)されている場合


# -- 8.9 モジュールに他のモジュールをincludeする

module Greeting
	def hello
		'hello'
	end
end

module Aisatu
	#別のモジュールincludeする
	include Greeting

	def konnichiwa
		'こんにちは'
	end
end

class User
	#Aisatuモジュールだけをincludeする
	include Aisatu
end

user = User.new
user.konnichiwa #=>"こんにちは"
user.hello #=> "hello"
#includeされているGreetingも呼び出し可能になった

#prependでモジュールをミックスインする

#prependの特徴は同名のメソッドがあったときにミックスインしたクラスよりも先にモジュールのメソッドが呼ばれる

module A
	def to_s
		"<A> #{super}"
	end
end

class Product
	#includeではなくprependを使う
	prepend A
	# include A

	def to_f
		"<Product> #{super}"
	end
end

product = Product.new
product.to_s #=> "<A><Product>"
product.to_s #=> "<Product>"
#"<A> <Product> #<Product:0x00007f8e72079858>"
Product.ancestors #=>[A, Product, Object, Kernel, BasicObject]


#prependで既存のメソッドを置き換える
#prependを活用できる場面の1つがオリジナル実装を活かした既存メソッドの置き換え
#prependがなかった頃は次の様にエイリアスメソッドを使って実現していた

class Product
	def name
		"A great film"
	end
end

#変更前のnameメソッドの実行結果
product = Product.new
product.name

#既存メソッドを変更するためにProduct クラスを再オープンする
class Product
	#既存のnameメソッドはname_originalという名前で呼び出せる様にしておく
	alias name_original name

	#nameメソッドの挙動を変える
	# (もともと実装されていたnameメソッドも再利用する)
	def name
		"<<#{name_original}>>"
	end
end

#変更後のnameメソッドの実行結果
product.name #=> "<<A great film>>"

#----------------
# #上記のコードはモジュールとprependを組み合わせることによってエイリアスメソッドの定義をなくすことができる
class Product
	def name
		"A great film"
	end
end

#prependするためのモジュールを定義する
module NameDecorator
	def name
		#prependするとsuperはミックスインした先のクラスのnameメソッドを呼び出す
		"<<#{super}>>"
	end
end

#既存のメソッドを変更するために Productクラスを再オープンする
class Product
	#includeではなくprependでミックスインする
	prepend NameDecorator
end
#上記を以下の一文にまとめることもできる
Product.prepend NameDecorator

#エイリアスメソッドを使ったときと同じ結果が得られる
product = Product.new
product.name

#他のクラスに対しても簡単に同じ変更ができる
class User
	def name
		'Alice'
	end
end

class User
	#prependを使えばUserクラスのメソッドも置き換えることができる
	prepend NameDecorator
end
#上記を以下の一文にまとめることもできる
User.prepend NameDecorator

#Userクラスのnameメソッドを上書きすることができる
user = User.new
p user.name #=> "<<Alice>>"

#有効範囲を限定できるrefinements

module StringShuffule
	refine String do
		def shuffle
			chars.shuffle.join
		end
	end
end
#refinementsを有効にするためにはusingというメソッドを使う
#通常はStringクラスにShuffleメソッドはない
'Alice'.shuffle #=> NoMethodError:undefined 

class User
	#refinementsを有効化する
	using StringShuffule

	def initialize(name)
		@name = name
	end

	def shuffled_name
		# Userクラスの内部であればStringクラスのshuffleメソッドが有効になる
		@name.StringShufful
	end

	#Userクラスを抜けるとrefinementsは無効になる
end

user = User.new('Alice')
#Userクラスないではshuddleメソッドが有効になっている
user.shuffled_name #=>"eAcil"

#Userクラスを経由しない場合はshuffleメソッドは使えない
'Alice'.shuffle #undefined method `shuffle' for "Alice":String

#usingメソッドはクラス公文とモジュール構文の内部で使用することができる。
#またトップレベルでも使用できるがその場合は有効範囲がusingで呼び出された場所からファイルの最後までになる


#StringShuffleモジュールを読み込む
require './string_shuffle'

#ここではまだshuffleメソッドが使えない
#puts 'Alice'.shuffle

#トップレベルでusingするとここからファイルの最後までshuffleメソッドが有効になる
using StringShuffle
puts 'Alice'.shuffle 

class User 
	def initialize(name)
		@name = name
	end

	def shuffled_name
		@name.shuffle
	end
end

user = User.new('Alice')
puts user.shuffled_name

puts 'Alice'.shuffle
#他のファイルではshuffleメソッドは使えない



require './string_shuffle'

#ここではまだshuffleメソッドが使えない
#puts 'Alice'.shuffle

#トップレベルでusingするとここからファイルの最後までshuffleメソッドが有効になる
using SomeModule
# puts 'Alice'.shuffle

class User
	def initialize(name)
		@name = name
	end

	def shuffled_name
		@name.shuffle
	end
end
#他のファイルではshuffleメソッドは使えない
user = User.new('Alice')
puts user.shuffled_name
puts [1,2,3,4].shuffle

#Ruby2.4からはモジュールもrefineできる様になった
module SomeModule
	refine Enumerable do
	end
end

#二重コロンとドットに違い

module Sample
	class User
		NAME = 'Alice'.freeze
		def self.hello(name = NAME)
			"Hello, I am #{name}"
		end
	end
end

#名前空間を区切ったり定数を参照したりするときは二重コロンを使い、メソッド呼び出す場合はドットを使うのが典型的な使い分け
Sample::User::NAME #=> "Alice"

Sample::User.hello #=> "Hello, I am Alice"

#メソッドの呼び出しに二重コロンを使うこともできる
Sample::User::hello #=> "Hello, I am Alice"

#普通の変数であっても::で呼び出せる
s::upcase #=> "ABC"






