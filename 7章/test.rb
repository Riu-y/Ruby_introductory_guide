# class User
# 	def initialize(name)
# 		@name = name
# 	end

# 	def hello
# 		#shuffled_nameはローカル変数
# 		shuffuled_name = @name.chars.shuffle.join
# 		"Hello, I am #{shuffuled_name}"
# 	end
# end
# p user = User.new('Alice')
# p user.hello


# class User
# 	def initialize(name)
# 		@name = name
# 	end

# 	# @nameを外部から参照するためのメソッド
# 	def name
# 		@name
# 	end
# end
# user = User.new('Alice')
# # nameメソッドを経由すて＠nameの内容を取得する
# p user.name #=> "Alice"


# class User
# 	def initialize(name)
# 		@name = name
# 	end

# 	# @nameを外部から参照するためのメソッド
# 	def name
# 		@name
# 	end

# 	#@nameを外部から変更するためのメソッド
# 	def name=(value)
# 		@name = value
# 	end
# end

# user = User.new('Alice')
# user.name = 'Bob'
# p user.name

# class User
# 	attr_accessor :name

# 	def initialize(name)
# 		@name = name
# 	end
# end

# user = User.new('Alice')
# p user.name
# user.name = 'Bob'
# p user.name

# class User
# 	attr_reader :name

# 	def initialize(name)
# 		@name = name
# 	end
# end

# user = User.new('Alice')
# p user.name
# user.name = 'Bob'
# p user.name

# class User
# 	attr_writer :name
# 	def initialize(name)
# 		@name = name
# 	end
# end

# user = User.new('Alice')
# user.name = 'Bob'
# p user.name

# class User
# 	attr_accessor :name, :age

# 	def initialize(name,age)
# 		@name = name
# 		@age = age
# 	end
# end
# user = User.new('Alice',20)
# p user.name
# p user.age

# class User
# 	def initialize(name)
# 		@name = name
# 	end

# 	#これはインスタンスメソッドinnsutannsumesoddo
# 	def hello
# 		#@nameの値はインスタンスによって異なる
# 		"Hello, I am #{@name}."
# 	end
# end
# alice = User.new('Alice')
# p alice.hello 

# bob = User.new('Bob')
# p bob.hello 

# class User
# 	def initialize(name)
# 		@name = name
# 	end
# 	def self.create_users(names)
# 		names.map do |name|
# 			User.new(name)
# 		end
# 	end
# 	def hello
# 		"Hello, I am #{@name}."
# 	end
# end

# names = ['Alice','Bob','Alex']
# users = User.create_users(names)
# users.each do |user|
# 	puts user.hello
# end

# class Product
# 	DEFAULT_PRICE = 0
# 	attr_reader :name, :price

# 	def initialize(name, price = DEFAULT_PRICE)
# 		@name = name
# 		@price = price
# 	end
# end

# product = Product.new('A free movie')
# p product.price

# class User
# 	attr_accessor :name

# 	def initialize(name)
# 		@name = name
# 	end

# 	def hello
# 		"Hello, I am #{name}"
# 	end

# 	def hi
# 		"Hi, I am #{self.name}"
# 	end

# 	def my_name
# 		"My name is #{@name}"
# 	end
# end
# user = User.new('Alice')
# p user.hello 
# p user.hi
# p user.my_name 


# class User
# 	attr_accessor :name

# 	def initialize(name)
# 		@name = name
# 	end

# 	def rename_to_bob
# 		name = 'Bob'
# 	end

# 	def rename_to_carol
# 		self.name = 'Carol'
# 	end

# 	def rename_to_dave
# 		@name = 'Dave'
# 	end
# end
# user = User.new('Alice')

# user.rename_to_bob
# p user.name #=>Alice リネームできていない
# user.rename_to_carol
# p user.name #=>carol
# user.rename_to_dave
# p user.name #=>dave

# class Foo
# 	#このputsはクラス定義の読み込み時に呼び出されている
# 	puts "クラス構文の直下のself: #{self}"

# 	def self.bar
# 		puts "クラスメソッド内のself: #{self} "
# 	end
# 	def baz
# 		puts "インスタンスメソッド内のself: #{self}"
# 	end
# end
# #=> クラス構文直下にself: foo
# Foo.bar #=>クラスメソッド内のself:Foo

# foo = Foo.new
# foo.baz #インスタンスメソッド内のself

# class Product
# 	attr_reader :name, :price

# 	def initialize(name,price)
# 		@name = name
# 		@price = price
# 	end

# 	#金額を整形するクラスメソッド
# 	def self.format_price(price)
# 		"#{price}円"
# 	end

# 	def to_s
# 		#インスタンスメソッドからクラスメソッドを呼び出す
# 		formatted_price = Product.format_price(price)
# 		"name: #{name},price: #{formatted_price}"
# 	end
# end

# product = Product.new('A great movie',1000)
# p product.to_s

# class Product
# 	attr_reader :name, :price

# 	def initialize(name, price)
# 		@name = name
# 		@price = price
# 	end
# end
# product = Product.new('A great movie',1000)
# product.name
# product.price

# class DVD < Product
# 	#nameとpriceはスーパークラスでattr_readerが定義されているので不要
# 	attr_reader :running_time

# 	def initialize(name,price,running_time)
# 		#スーパークラスにも存在している属性
# 		@name = name
# 		@price = price
# 		#DVD独自の属性
# 		@running_time = running_time
# 	end
# end

# dvd = DVD.new('A great movie',1000,120)
# p dvd.name
# p dvd.price
# p dvd.running_time

# class Product
# 	attr_reader :name, :price

# 	def initialize(name, price)
# 		@name = name
# 		@price = price
# 	end

# 	def to_s
# 		"name: #{name}, price:#{price}"
# 	end
# end

# class DVD < Product
# 	attr_reader :running_time

# 	def initialize(name,price,running_time)
# 		super(name,price)
# 		@running_time = running_time
# 	end

# 	def to_s
# 		#superでスーパークラスのto_sメソッドを呼び出す
# 		"#{super}, running_time: #{running_time}"
# 	end
# end

# product = Product.new('A great movie',1000)
# p product.to_s
# #=> "#<Product:0x00007fa0e79157c8>"

# dvd = DVD.new('An awesome film',3000,120)
# p dvd.to_s
# #=> "#<DVD:0x00007fa0e7915638>"


# class User
# 	def hello
# 		#name メソッドはprivateなのでselfをつけるtエラーになる
# 		"Hello, I am #{self.name}"
# 	end

# 	private
# 	def name
# 		('Alice')
# 	end
# end
# user = User.new
# user.hello #=> Error

# class User
# 	class << self
# 		private
# 		def hello

# 			'Hello'
# 		end
# 	end
# end

# class User
# 	def self.hello
# 		'hello'
# 	end
# 	private_class_method :hello
# end
# User.hello


#後からメソッドの公開レベルを変更する場合
# class User
# 	def foo
# 		'foo'
# 	end

# 	def bar
# 		'bar'
# 	end

# 	#fooとbarをprivateメソッドに変更する
# 	private :foo, :bar

# 	#bazはpublicメソッド
# 	def baz
# 		'baz'
# 	end
# end

# user = User.new
# p user.baz #=> "baz"

# class User
# 	attr_reader :name

# 	def initialize(name, weight)
# 		@name = name
# 		@weight = weight
# 	end

# 	def heavier_than?(other_user)
# 		other_user.weight < @weight
# 	end

# 	protected

# 	def weight
# 		@weight
# 	end
# end
# alice = User.new('Alice',50)
# bob = User.new('Bob',60)
# p bob.heavier_than?(alice)

# class Product
# 	@name = 'Product'
# 	def self.name
# 		@name
# 	end
# 	def initialize(name)
# 		@name = name
# 	end

# 	def name
# 		@name
# 	end
# end
# Product.name #=> "Product"
#  product = Product.new('A great movie')
# p product.name
# p Product.name

# class Product
# 	attr_accessor :name, :author
# #スーパークラス
# 	#クラスインスタンス変数
# 	@name = 'Product'
# 	#クラスインスタンス変数
# 	def self.name
# 		@name
# 	end
# 	#インスタンス変数
# 	def initialize(name, author)
# 		@name = name
# 		@author = author
# 	end
# 	#インスタンス変数
# 	def name
# 		@name
# 	end
# end
# #サブクラス
# 	class DVD < Product
# 		#クラスインスタンス変数
# 		@name = 'DVD'
# 	#クラスインスタンス変数
# 	def self.name
# 		#クラスインスタンス変数を参照
# 		@name
# 	end
# 	#クラスインスタンス変数
# 	def upcase_name
# 		#インスタンス変数を参照
# 		@name.upcase
# 	end
# end

# Product.name #=> "Product"
# DVD.name #=> DVD

# product = Product.new('A great movie','Bob')
# p product.name #=> "A great"movie"

# dvd = DVD.new('An awesome film','Tony')
# p dvd.name  #=> "An awesome FILM"
# p dvd
# p dvd.upcase_name #=> AN AWESOME FILM

# prodect = Product.new('This is product','Bob')
# p product.name

# p Product.name #=> "Product"
# p DVD.name #=> "DVD"

#グローバル変数の宣言と値の代入
# $program_name = 'Awesome program'

# #グローバル変数に依存するクラス
# class Program
# 	def initialize(name)
# 		$program_name = name
# 	end

# 	def self.name
# 		$program_name
# 	end

# 	def name
# 		$program_name
# 	end
# end

# #$program_nameは既に名前が代入されている
# p Program.name #=>"Awesome program"

# program = Program.new('Super program')
# p program.name #=> "Super program"

# #Program.newのタイミングで$program_nameが”Super program"に変更される
# p Program.name #=> "Super program"
# p$program_name #=> "Super program"

# class User
# 	class BloodType
# 		attr_reader :type

# 		def initialize(type)
# 			@type = type
# 		end
# 	end
# end

# blood_type = User::BloodType.new('B')
# p blood_type.type

# class User
# 	# =で終わるメソッドを定義する
# 	def name=(value)
# 		@name = value
# 	end
# end

# user = User.new
# #変数に代入する様な形式でname=メソッドを呼び出せる
# user.name = 'Alice'
# p user

# class Product
# 	attr_reader :code, :name

# 	def initialize(code,name)
# 		@code = code
# 		@name = name
# 	end
	
# 	#以下のコードがないとスーパークラスのObjectクラスでは、==はobject_idが一致したときにtrueを返すという仕様になっているためfalseで返してしまう
# 	def ==(other)
# 		if other.is_a?(Product)
# 			#もし商品コードが一致すれば同じProductとみなす
# 			code == other.code
# 		else
# 			#oherがProductでなければ常にfalse
# 			false
# 		end
# 	end
# end

# #aとcが同じ商品コード
# a = Product.new('A-0001', 'A great movie')
# b = Product.new('B-0001', 'A awesome movie')
# c = Product.new('A-0001', 'A great movie')

# # ==がこの様に動作して欲しい
# p a == b #=>false
# p a == c #=>true

# a = 'japan'
# b = 'japan'
# a.eql?(b)
# p a.hash
# p b.hash

# c = 1
# d = 1.0
# c.eql?(d)
# p c.hash
# p d.hash


# value = [1,2,3]

# case value
# when String
# 	puts '文字列です'
# when Array
# 	puts '配列です'
# when Hash
# 	puts 'ハッシュです'
# end
# #=>配列です

# class MyString < String
# 	#Stringクラスを拡張するためのコードを書く
# end
# s = MyString.new('hello')
# p s #=> 'Hello'
# p s.class #=> "MyString"


# class String
# 	def shuffle
# 		chars.shuffle.join
# 	end
# end

# s = 'Hello, I am Alice.'
# p s.shuffle

# class User
# 	def initialize(name)
# 		@name = name
# 	end

# 	def hello
# 		"Hello, #{@name}!"
# 	end
# end

# #モンキーパッチをあたるためにUserクラスを再オープンする
# class User
# 	#既存のhelloメソッドはhello _originalとして呼び出せる様にしておく
# 	alias hello_original hello

# 	#helloメソッドにモンキーパッチを当てる（もともと実装されていたhelloメソッドも再利用する）
# 	def hello
# 		"#{hello_original}じゃなくて、#{@name}さん、こんにちは！"
# 	end
# end

# user = User.new('tarou')
# p user.hello
# p user.hello_original

# def display_name(object)
# 	puts "Name is << #{object.name}>>"
# end
# #上記のメソッドは引数で渡されたオブジェクトがnameメソッドを持っていること(object.nameが呼び1出せること)を期待している。
# #それ以外のことは何も気にしないので以下の様に全く別々のオブジェクトを渡すことができる
# class User
# 	def name
# 		'Alice'
# 	end
# end

# class Product
# 	def name
# 		'A great movie'
# 	end
# end


# #UserクラスとPriductクラスはお互いに無関係なクラスだが、displeayUserfileメソッドは何も気にしない
# user = User.new
# p display_name(user)

# product = Product.new
# p display_name(product)

# str = "I am Riu."
# p str.split

# p "1 23 456".split
# class Object

# 	def display_name(object)
# 		if object.respond_to?(:name)
# 			puts "Name is <<#{object.name}>>"
# 		else
# 			puts "No name."
# 		end
# 	end
# end

# 	s = 'Alice'
# 	p s.respond_to?(:split) #=>true
# 	p display_name(s)

# 	n = "Riu"
# 	p n.respond_to?(:name)
# 	p display_name(n)

# def add_ten(n)
# 	#nが整数以外の場合にも対応するためto_iで整数に変換する
# 	n.to_i + 10
# end

# #整数を渡す
# p add_ten(1)

# #文字列やnilを渡す
# p add_ten('2') #=>12
# p add_ten('-2')
# p add_ten(nil) #=>10
# p add_ten(0)
# p add_ten(5)


def add_numbers(a = 10,b = 0)
	a + b
end

#引数の個数はゼロでも1個でも2個でも良い
p add_numbers #=>0
p add_numbers(1)
p add_numbers(1,2)
p add_numbers(1,5)
