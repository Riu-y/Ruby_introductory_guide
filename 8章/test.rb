# module Loggable
# 	def log(text)
# 		puts "[LOG] #{text}"
# 	end
# end

# class Product
# 	#上で作ったモジュールをincludeする
# 	include Loggable

# 	def title
# 		#logメソッドはLoggaableモジュールで定義したメソッド
# 		log 'title is called.'
# 		'A great movie'
# 	end
# end

# class User
# 	include Loggable

# 	def name
# 		log 'name is called.'
# 		'Alice'
# 	end
# end

# product = Product.new
# p product.title

# user = User.new
# p user.name

# module Loggable
# 	def log(text)
# 		puts "[LOG]#{text}"
# 	end
# end

# class Product
# 	#Loggableモジュールのメソッドを特異メソッドとしてミックスインする
# 	extend Loggable

# 	def self.create_products(names)
# 		#logメソッドをクラスメソッド内で呼び出す
# 		#つまりlogメソッド自体もクラスメソッドになっている
# 		log 'create_products is called'
# 	end
# end

# #クラスメソッド経由でlogメソッドが呼び出される
# Product.create_products([])

# #Productクラスのクラスメソッドとして直接呼び出すことも可能
# Product.log('Hello')

# class Product
# 	extend Loggable

# 	# log メソッドをクラス公文の直下で呼び出す
# 	#（クラスが読み込まれるタイミングでこのlogメソッドも実行される）
# 	log 'Defined Product class.'
# # end

# module Taggable
# 	def price_tag
# 		#priceメソッドはinclude先で定義されている前提
# 		"#{price}円"
# 	end
# end

# class Product
# 	include Taggable

# 	def price
# 		1000
# 	end
# end

# product = Product.new
# p product.price_tag #=> "1000円"


#all?
# p [1,2,3].all?{ |v| v > 0 }
# #=> true
# p [1,2,3].all?{ |v| v < 1 }
# #=>false

# #上記をeachで書くと
# flg = true
# (1..3).each do |v|
# 	if v <= 0
# 		flg = false
# 		break
# 	end
# end
# p flg

# p [[1,2],[3,4],[6,8]].flat_map { |v| v.map {|cv| cv * 2} }
# num = []
# [[1,2],[3,4]].each do |n|
# 	n.each do |c|
# 		num << c * 2
# 	end
# end
# p num

# p [1,3,7].detect { |v| (3..5).include?(v) } 


# p [1,3,7].find { |v| (3..5).include?(v) } 

# num = []
# [1,3,7].each do |n|
# 	if (3..5).include?(n)
# 		num << n
# 	end
# end
# p num

# class Tempo
# 	include Comparable
# 	attr_reader :bpm

# 	def initialize(bpm)
# 		@bpm = bpm
# 	end

# 	# <=>はComparableモジュールで使われる演算子
# 	def <=>(other)
# 		if other.is_a?(Tempo)
# 			#bpm同士を<=>で比較した結果を返す
# 			bpm <=> other.bpm
# 		else
# 			nil
# 		end
# 	end

# 	def inspect
# 		"#{bpm}bpm"
# 	end
# end

# p t_120 = Tempo.new(120) #=> 120bpm
# p t_180 = Tempo.new(180) #=> 180bpm

# p t_120 > t_180
# p t_120 <= t_180
# p t_120 == t_180

# p self
# p self.class

# class User
# 	p self
# 	p self.class
# end


# class User
# 	p self #=>User
# 	p self.class #=>Class
# end

# p User.class #=> Class

# p Class.superclass #=> Module

# module Loggable
# 	p self #=> Logaable
# 	p self.class #=> Module
# end

# p Loggable.class #=> Module

# p Module.superclass #=> Object


#  module NameChanger
#  	def change_name
#  		#セッターメソッド経由でデータを変更する
#  		self.name = 'アリス'
#  	end
#  end

# class User
# 	include NameChanger

# 	attr_accessor :name

# 	def initialize(name)
# 		@name = name
# 	end
# end

# p user = User.new('alice')
# user.change_name
# p user.name

# Math.sqrt(2) 

# class Calculator
# 	include Math

# 	def calc_sqrt(n)
# 		#ミックスインとしてMathモジュールのsqrtメソッドを使う
# 		sqrt(n)
# 	end
# end

# calculator = Calculator.new
# p calculator.calc_sqrt(2)

# p Math::E #自然対数の底
# p Math::PI #円周率

# 状態を保持するモジュールの作成

# module AwesomeApi
# 	#設定値を保持するインスタンス変数を用意する
# 	@base_url = ''
# 	@debag_mode = false

# 	#クラスインスタンス変数を読み書きするための特異メソッドを定義する
# 	class << self
# 		def base_url=(value)
# 			@base_url = value
# 		end

# 		def base_url
# 			@base_url
# 		end

# 		def debug_mode=(value)
# 			@debug_mode = value
# 		end

# 		def debug_mode
# 			@debug_mode
# 		end
# 		#本来は以下の1行ですむ
# 		#attr_accessor :base_url, :debug_mode
# 	end
# end
# #設定値を保存する
# AwesomeApi.base_url = 'http://example.com'
# AwesomeApi.debug_mode = true

# #設定値を参照する
# p AwesomeApi.base_url
# p AwesomeApi.debug_mode

# #Singletonモジュールを使う
#モジュールだけでなくクラスを使ってデザインパターン本来のシングルトンパターンを実現する場合位はSingletonモジュールを使うと便利。
# このモジュールをincludeすると以下の様に挙動が変わる
# ・newメソッドがprivateとなり、外部から呼び出せなくなる
# ・クラスの特異メソッドとしてinstanceメソッドが定義されここから「唯一、1つだけ」のインスタンスを取得できる

# require 'singleton'

# class Configuration
# 	#Singletonモジュールをincludeする
# 	include Singleton

# 	attr_accessor :base_url, :debug_mode

# 	def initialize
# 		#設定値を初期化
# 		@base_url = ''
# 		@debug_mode = false
# 	end
# end
# # #Configurationクラスはnewできない
# # config = Configuration.new #=> Error

# #instanceメソッドを使ってインスタンスを取得する
# config = Configuration.instance
# #設定値を設定する
# config.base_url = 'http://example.com'
# config.debug_mode = true

# #instanceメソッドを使って再度インスタンスを取得する
# p other = Configuration.instance
# p other.base_url #=> "http://example.com"
# p other.debug_mode #=>true

# #どちらも全く同じオブジェクト（インスタンス）になっている
# p config.object_id
# p other.object_id
# p config.equal?(other)


# p Configuration.ancestors

# module A
# 	def to_s
# 		"<A> #{super}"
# 	end
# end

# class Product
# 	#includeではなくprependを使う
# 	prepend A
# 	# include A

# 	def to_s
# 		"<Product> #{super}"
# 	end
# end

# product = Product.new
# p product.to_s #=> "<A><Product>"
# p product.to_s #=> "<Product>"
# p Product.ancestors

# class Product
# 	def name
# 		"A great film"
# 	end
# end

# #変更前のnameメソッドの実行結果
# product = Product.new
# p product.name

# #既存メソッドを変更するためにProduct クラスを再オープンする
# class Product
# 	#既存のnameメソッドはname_originalという名前で呼び出せる様にしておく
# 	alias name_original name

# 	#nameメソッドの挙動を変える
# 	# (もともと実装されていたnameメソッドも再利用する)
# 	def name
# 		"<<#{name_original}>>"
# 	end
# end

# #変更後のnameメソッドの実行結果
# p product.name #=> "<<A great film>>"


# # #上記のコードはモジュールとprependを組み合わせることによってエイリアスメソッドの定義をなくすことができる
# class Product
# 	def name
# 		"A great film"
# 	end
# end

# #prependするためのモジュールを定義する
# module NameDecorator
# 	def name
# 		#prependするとsuperはミックスインした先のクラスのnameメソッドを呼び出す
# 		"<<#{super}>>"
# 	end
# end

# #既存のメソッドを変更するために Productクラスを再オープンする
# class Product
# 	#includeではなくprependでミックスインする
# 	prepend NameDecorator
# end
# #上記を以下の一文にまとめることもできる
# Product.prepend NameDecorator

# #エイリアスメソッドを使ったときと同じ結果が得られる
# product = Product.new
# product.name

# #他のクラスに対しても簡単に同じ変更ができる
# class User
# 	def name
# 		'Alice'
# 	end
# end

# class User
# 	#prependを使えばUserクラスのメソッドも置き換えることができる
# 	prepend NameDecorator
# end
# #上記を以下の一文にまとめることもできる
# User.prepend NameDecorator

# #Userクラスのnameメソッドを上書きすることができる
# user = User.new
# p user.name #=> "<<Alice>>"

# module StringShuffle
# 	refine String do
# 		def shuffle
# 			chars.shuffle.join
# 		end
# 	end
# end
# #refinementsを有効にするためにはusingというメソッドを使う
# #通常はStringクラスにShuffleメソッドはない
# # 'Alice'.shuffle #=> NoMethodError:undefined 

# class User
# 	#refinementsを有効化する
# 	using StringShuffle

# 	def initialize(name)
# 		@name = name
# 	end

# 	def shuffled_name
# 		# Userクラスの内部であればStringクラスのshuffleメソッドが有効になる
# 		@name.shuffle
# 	end

# 	#Userクラスを抜けるとrefinementsは無効になる
# end

# user = User.new('Alice')
# p user.shuffled_name
# # 'Alice'.shuffle

#StringShuffleモジュールを読み込む
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
