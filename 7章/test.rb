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


class User
	def hello
		#name メソッドはprivateなのでselfをつけるtエラーになる
		"Hello, I am #{self.name}"
	end

	private
	def name
		('Alice')
	end
end
user = User.new
user.hello #=> Error


