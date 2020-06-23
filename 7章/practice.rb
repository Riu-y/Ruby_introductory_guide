# ----- 7章 クラスの作成を理解する -----

# ---7.2 オブジェクト指向のプログラミング ---

user = []
users << { first_name: 'Alice', last_name: 'Ruby',age: 20}
users << {first_name: 'Bob',last_name:'Python	',age: 30}

users.each do |user|
	puts "氏名: #{user[:first_name]} #{user[:last_name]}、年齢: #{user[:age]}"
end
#=> 氏名: Alice Ruby、年齢: 20 
#=> 氏名: Bob Python、年齢: 30

#氏名を作成するメソッド
def full_name(user)
	"#{user[:first_name]} #{user[:last_name]}"
end

#ユーザーのデータを表示する
users.each do |user|
	puts "氏名: #{full_name(user)}、年齢: #{user[:age]}"
end

#ハッシュだとタイプミスしてもnilが返るだけなので不具合に気付きづらい
users[0][:first_mmmm] #=>nil

#他にもハッシュは新きキーを追加したり、内容を変更したりできるので脆くて壊れやすいプログラムになりがち

#勝手に新しいキーを追加
users[0][:country] = "japan"
#勝手にfirst_nameを変更
users[0][:first_name] = 'Carol'
#ハッシュの中身が変更される
users[0] #=> {:first_name=>"Carol", :last_name=>"Ruby", :age=>20, :country=>"japan"}

#大きなプログラムではハッシュの代わりにクラスを使用する

#Userクラスを定義する
class User
	attr_reader :first_name, :last_name, :age

	def initialize(first_name,last_name,age)
		@first_name = first_name
		@last_name = last_name
		@age = age
	end
end

#ユーザーのデータを作成
users = []
users << User.new('Alice','Ruby',20)
users << User.new('Bob','Python',30)

#氏名を作成するメソッド
def full_name(user)
	"#{user.first_name} #{user.last_name}"
end

#ユーザーのデータを表示する
users.each do |user|
	puts "氏名: #{full_name(user)}、年齢, #{user.age}"
end
#Userクラスを導入するとタイプミスの時にエラーが発生する
user[0].first_name #=> Alice
user[0].first_aaaa #=> NoMethodError

#新しく属性を追加したり内容を変更したりすることも防止する
users[0].country = 'japan'
#=> NomethodError

#勝手にfirst_nameを変更できない
users[0].first_name = 'Carol'
#=> NoMethodError

#クラスの内部にメソッドを追加することもできるクラス内部でメソッドを定義したほうがシンプルになる
class User
	attr_reader :first_name,:last_name,:age

	def initialize(first_name,last_name,age)
		@first_name = first_name
		@last_name = last_name
		@age = age
	end

	def full_name(user)
		"#{first_name} #{last_name}"
	end
end

#-- オブジェクト指向プログラミング関連の用語

クラス
クラスは一種のデータ型。オブジェクトの設計図とかオブジェクトの雛形とも呼ばれる。Rubyではオブジェクトは何かしらのクラスに属している

オブジェクト、インスタンス、レシーバ
#「Alice Rubyさん20歳」というオブジェクトを作成する
alice = User.new('Alice','Ruby',20)
#「Bob Pythonさん、30歳」というユーザのオブジェクトを作成する。
bob = User.new('Bob','Python', 30)

#どちらもfull_nameメソッドを持つが保持しているデータが異なるので戻り値は異なる
alice.full_name
#=> "Alice Ruby"
bob.full_name
#=> "Bob Ptyhon"

# このようにクラスをもとに作られらデータの塊をオブジェクトと呼ぶ。場合によってはインスタンスと呼ぶこともある。
# また以下のように書かれたコードで「ここでのfirst_nameメソッドのレシーバはuserです」と表現する場合もある。
user = User.new('Alice','Ruby',20)
user.first_name

# メソッド、メッセージ
# オブジェクトが持つ動作や振る舞いをメソッドと呼ぶ。
# 他の言語では関数やサブルーチンと表現される。
alice = User.new('Alice','Ruby',20)
user.first_name
# 「2行目ではuserというレシーバに対してfirst Userfileというメッセージを送っている」と表現される。
# レシーバとメッセージはsmalltalkというオブジェクト指向言語でeetよく使われる呼び方

# 状態（ステート）
# オブジェクトごとに保持されるデータのことを「オブジェクトの状態（ステート）と呼ぶことがある

# 属性（アトリビュート、プロパティ）
class User
	#first_nameの読み書きを許可する
	attr_accessor :first_name

	def initialize(first_name,last_name,age)
		@first_name = first_name
		@last_name = last_name
		@age = age
	end
end

user = User.new('Alice','Ruby',20
	user.first_name #=> "Alice"
	user.first_name = 'アリス'
	user.first_name #=> "アリス"
# 上記のようにオブジェクトから取得（もしくはオブジェクトに設定）できる値のことを属性（もしくはアトリビュート、プロパティ）と呼ぶ。

# ----- 7.3 クラスの定義 ------

#クラスの定義は必ず大文字で始める。慣習としてUserやOrderItemのようにキャメルケースで書くのが一般的

User.new
#この時に呼ばれるはInitializeメソッド。
class User
	def initialize
		puts 'Initialize.'
	end
end
User.new
#initializeメソッドは特殊なメソッドで外部から呼び出すことはできない（デフォルトでprivateメソッドになっている）
#initializeメソッドに引数をつけるとnewメソッドで呼ぶ時にも引数が必要になる
class User
	def initialize(name, age)
		puts "name: #{name}, age:#{age}"
	end
end

#インスタンスメソッドの定義
#クラス公文の内部でメソッドを定義するとそのメソッドはインスタンスメソッドになるインスタンスメソッドはその名の通り、そのクラスのインスタンスに対して呼び出すことができる。
class User
	def hello
		"Hello"
	end
end
user = User.new
#インスタンスメソッドのよびだし
user.hello #=>”Hello!

#インスタンス変数とアクセサメソッド
class User
	def initialize(name)
		#インスタンス作成時に渡された名前をインスタンス変数に保存する
		@name = name
	end

	def hello
		#インスタンス変数に保存されている名前を表示する
		"Hello,I am #{@name}"
	end
end
user = User.new('Alice')
user.hello #=> "Hello, I am Alice"

#メソッドのブロックの内部で作成される変数のことをローカル変数と呼ぶ。
#ローカル変数はメソッドやブロックでのみ有効。メソッドやブロックが呼び出される度ひ毎回作り直される。
class User
	def hello
		#shuffled_nameはローカル変数
		shuffuled_name = @name.chars.shuffle.join
		"Hello, I am #{shuffuled_name}"
	end
end
user = User.new('Alice')
user.hello #=> Hello, "I am cieAl"

#作成されていないローカル変数を参照しようとするとエラーになる
#作成されていないインスタンス変数を参照した場合はnilになる

#インスタンス変数はクラスの外部から参照することができない。もし参照したい場合は参照用のメソッドを作る必要がある
class User
	def initializse(name)
		@name = name
	end

	# @nameを外部から参照するためのメソッド
	def name
		@name
	end
end
user = User.new('Alice')
# nameメソッドを経由すて＠nameの内容を取得する
user.name #=> "Alice"

#同じくインスタンス変数の内容を外部から変更したい場合も変更用のメソッドを定義する。
#Rubyでは=で終わるメソッドを定義すると変数に代入するような形でそのメソッドを呼び出すことができる

class User
	def initialize(name)
		@name = name
	end

	# @nameを外部から参照するためのメソッド
	def name
		@name
	end

	#@nameを外部から変更するためのメソッド
	def name=(value)
		@name = value
	end
end
user = User.new('Alice')
user.name = 'Bob'
user.name #=> "Bob"
#このようにインスタンス変数の値を読み書きするメソッドのことを「アクセサメソッド」と呼ぶ。（他の言語ではゲッターメソッドやセッターメソッドと呼ばれることもある）
#Rubyの場合では attr_accessor というメソッドでメソッド定義を省略できる

class User
	#@nameを読み書きするメソッドが自動的に定義される
	attr_accessor :name

	def initialize(name)
		@name = name
	end
	# nameメソッドやname=メソッドを明示的に定義する必要がない
end
user = User.new('Alice')
# @nameを変更する
user.name = 'Bob'
user.name #=> 'Bob'

#インスタンス変数の内容を読み取り専用にしたい場合はattr_readerメソッドが使える

class User
	attr_reader :name
	def initialize(name)
		@name = name
	end
end
user = User.new('Alice')
#@nameの参照はできる
user.name #=>"Alice"

#@nameを変更しようとするとエラーになる
user.name = 'Bob'
user.name #=>NoMethodError

#インスタンス変数の内容の書き込み専用にしたい場合はattr_writerが使える
class User
	attr_writer :name
	def initialize(name)
		@name = name
	end
end
user = User.new('Alice')
user.name = 'Bob'
user.name #=> NoMethodError

#カンマで複数の引数を渡すと複数のインスタンス変数に対するアクセサメソッドを作成することができる
class User
	attr_accessor :name, :age

	def initialize(name,age)
		@name = name
		@age = age
	end
end
user = User.new('Alice',20)
user.name
user.age

#-- クラスメソッドの定義 --
 クラス公文の内部で普通にメソッドを定義するとそのメソッドはインスタンスメソッドになる


class User
	def initialize(name)
		@name = name
	end

	#これはインスタンスメソッドinnsutannsumesoddo
	def hello
		#@nameの値はインスタンスによって異なる
		"Hello, I am #{@name}."
	end
end
alice = User.new('Alice')
#インスタンスメソッドはインスタンス（オブジェクト）に対して呼び出す
alice.hello #=>"Hello, I am Alice."

bob = User.new('Bob')
#インスタンスによって内部のデータが異なるので、helloメソッドの結果も異なる
bob.hello #=>"Hello, I am Bob."

#クラスメソッドを定義する場合はselfをつける
#パターン1
class User
	def self.initialize
		@name = name
	end
end

#パターン2
class User
	class << self
		def initialize
			@name = name
		end
	end
end

#クラスメソッドを呼び出すときはクラス名.メソッド名とする
class User
	def initialize(name)
		@name = name
	end

	#selfをつけるとクラスメソッドになる
	def self.create_users(names)
		names.map do |name|
			User.new(name)
		end
	end

	#これはインスタンスメソッド
	def hello
		"Hello,I am #{@name}"
	end
end

names = ['Alice','Bob','Carol']
#クラスメソッドの呼び出し
users = User.create_users(names)
users.each do |user|
	puts user.hello
end

#メソッド名の表記法について
#Rubyではインスタンスメソッドを表す際に”クラス名#メソッド名”を書くことがある
# Srting#to_iであればstringクラスのto_iメソッドを表す

# 定数
# クラスの中には定数を定義することもできる。
class Product
	#デフォルトの価格を定数として定義する
	DEFAULT_PRICE = 0
	attr_reader :name, :price

	def initialize(name, price = DEFAULT_PRICE)
		@name = name
		@price = price
	end
end

product = Product.new('A free movie')
product.price
#定数は必ず大文字で始める必要があり、慣習的にあるがベットの大文字と数字、_で構成されることが多い
#定数名の例DEFAULT_PRICE = 0
#UNITS = { m: 1.0,ft: 3.28, in:39.37}

#定数はインスタントメソッド内でも同じ方法で参照することができる
class Product
	DEFAULT_PRICE = 0
	def self.default_price
		#クラスメソッドから定数を参照する
		DEFAULT_PRICE
	end

	def default_price
		#インスタンスメソッドから定数を参照する
		DEFAULT_PRICE
	end
end

Product.default_price #=>0

product = Product.new
product.default_price #=>0

# ----- 7.4 例題:改札機のプログラム -----

# -----7.5 selfキーワード ------

class User
	attr_accessor :name

	def initialize(name)
		@name = name
	end

	def hello
		#selfなしでnameメソッドを呼ぶ
		"Hello, I am #{name}"
	end

	def hi
		#self付きでnameメソッドを呼ぶ
		"Hi, I am #{self.name}"
	end

	def my_name
		#直接インスタンス変数の@nameにアクセスする
		"My name is #{@name}"
	end
end
user = User.new('Alice')
user.hello #=> "Hello,I am Alice"
user.hi  #=> #=> "Hi,I am Alice"
user.my_name #=> "My name is Alice"
end

#selfのつけ忘れで不具合が発生するケース
class User
	attr_accessor :name

	def initialize(name)
		@name = name
	end

	def rename_to_bob
		#selfなしでメソッドを呼ぶ
		name = 'Bob'
	end

	def rename_to_carol
		#self付きでname=メソッドを呼ぶ
		self.name = 'Carol'
	end

	def rename_to_dave
		#直接インスタンス変数を書き終える
		@name = 'Dave'
	end
end
user = User.new('Alice')

user.rename_to_bob
user.name #=>Alice リネームできていない
#これはnameというローカル変数に”Bob”という文字列を代入しただけだと判断されてしまう。
#そのため今回のようにセッターメソッドを呼び出したい場合は必ずselfを付ける必要がある。

user.rename_to_carol
user.name #=>carol

user.rename_to_dave
user.name #=>dave

# --クラスメソッドやクラス構文直下のself
class Foo
	#このputsはクラス定義の読み込み時に呼び出されている
	puts "クラス構文の直下のself: #{self}"

	def self.bar
		puts "クラスメソッド内のself: #{self} "
	end
	def baz
		puts "インスタンスメソッド内のself: #{self}"
	end
end
#=> クラス構文直下にself: foo
Foo.bar #=>クラスメソッド内のself:Foo

foo = Foo.new
foo.baz #インスタンスメソッド内のself  #<Foo:0x00007fc0db056538>

#Fooと表示されているクラス構文直下と区タスメソッドでのselfは「Fooクラス自身」を表している
#インスタンスメソッド内でのselfは「Fooクラスのインスタンス」を表している

class Foo
	def self.bar
		#クラスメソッドからインスタンスメソッドを呼び出す（エラー）
		self.baz
	end
	#インスタンスメソッドからクラスメソッドを呼び出す（エラー）
	def baz
		self.bar
	end
end
#クラスメソッドからインスタンスメソッドを呼び出したりインスタンスメソッドからクラスメソッドを呼び出そうとするとエラーになる

#クラス公文のdiary 直下ではクラスメソッドを呼び出すことはできる。selfがどちらもクラス自身になるから。
#この場合でもクラスメソッドを定義した後に下側でクラスメソッドを呼び出す必要はある
class Foo
	#この時点ではクラスメソッドbarが定義されていないので呼び出せない
	def self.bar
		puts 'Hello'
	end
	self.bar #クラス構文の直下でクラスメソッドを呼び出す
end

#Rubyの場合はクラス定義自体も上から順番に実行されるプログラムになっているのでクラス構文直下でクラスメソッドも呼び出すことができる
#極端だが以下のようなことも可能

class Foo
	3.times do
		puts 'Hello'
	end
end
#=>Hello
#=>Hello
#=>Hello

# -- クラスメソッドをインスタンスメソッドで呼び出す
class Product
	attr_reader :name, :price

	def initialize(name,price)
		@name = name
		@price = price
	end

	#金額を整形するクラスメソッド
	def.self.format_price(price)
		"#{price}円"
	end

	def to_s
		#インスタンスメソッドからクラスメソッドを呼び出す
		formatted_price = Product.format_price(price)
		"namw: #{name},price: #{formatted_price}"
	end
end

product = Product.new('A great movie',1000)
product.to_s #"name: A great movie,price: 1000円"

#self.classは「インスタンスが属しているクラス（上の例であればProductクラス）」を返すので結果として
#クラス.メソッドのように書くのと同じなため、self.class.メソッドとも書ける。

# ---- 7.6 クラスの継承 -----

# 親クラスをスーパークラス、小クラスをサブクラスとも呼ばれる
# 継承は「スーパークラスの機能を全て引きつぐための仕組み」とみなされる場合があるがそれは誤り
# 継承を使いたいと思った場合は機能ではなく、性質や概念が共通点に着目する
# 「サブクラスはスーパークラスの一種である」と声に出した時に違和感がないかどうか
# これは「is aの関係」と呼ばれる。商品クラスがスーパー、DVDがサブクラスだった特に、「DVDは商品の一種である」と声に出しても違和感がなければ適切なケースである可能性が高い。

#でファルとで継承されるObjectクラス
class User
end
#クラスにメソッドを何も定義していなくてもUserクラスのオブジェクトは以下のメソッドを呼び出すことができる
user = User.new
user.to_s #=>nil
user.nil? #=>false
#これはUserクラスがObjectを継承するから
User.superclass #=>0bject
次のようにすると継承したメソッドの一覧を確認できる
user = User.new
user.method.sort #=>[:!,:!=......]

#オブジェクトのクラスを確認する
user = User.new
user.class #=> User

user = User.new

#userはUserクラスのインスタンスか？
user.instance_of?(User) #=>true
#userはStringクラスのインスタンスか？
user.instance_of?(String) #=>false

継承関係を含めて確認したい場合は is_a? メソッドを使う
user = User.new
#instance_of?はクラスが全く同じでないとtrueにならない
user.instance_of?(Object) #=> false

#is_a?はis_a関係であればtrueになる
user.is_a?(User) #=> true
user.is_a?(Object) #=>true
user.is_a?(BasicObject) #=>true

#is-a関係にない場合はfalse
user.is_a?(String) #=>false

#他のクラスを継承したクラスを作る
# class サブクラス < スーパークラス
# end

#DVDクラスはProductクラスを継承する
class DVD < Product
end

#superでスーパークラスのメソッドを呼び出す
class Product
	attr_reader :name, :price

	def initialize(name, price)
		@name = name
		@price = price
	end
end
product = Product.new('A great movie',1000)
product.name
product.price

class DVD < Product
	#nameとpriceはスーパークラスでattr_readerが定義されているので不要
	attr_reader :running_time

	def initialize(name,running_time)
		#スーパークラスのinitializeメソッドを呼び出す
		# @name = name
		# @price = price
		super(name,price)

		#DVD独自の属性
		@runnning_time = running_time
	end
end

dvd = DVD.new('A great movie',1000,120)
dvd.name
dvd.price
dvd.running_time

#仮にスーパークラスとサブクラスのcss 引数が同じだった場合は引数なしのsuperを呼ぶだけで自分んい渡された引数を全てスーパーに引き渡せる
class DVD < Product
	#以下のinitializeメソッドは省略可能
	# def initialize(name,price)
	# #引数を全てスーパークラスのメソッドに渡す。つまりsuper(name,price))と書いたのと同じ
	# super
	#サブクラスで必要初期化処理を書く
	end
end
dvd = DVD.new('A great movie',1000)
dvd.name #=> 'A great movie'
dvd.price #=> 1000

#super()と書くと引数なしでスーパークラスを呼び出すことになるので注意
#そもそもスーパークラスとサブクラスで実行する処理が変わらなければサブクラスで同盟メソッドを定義したりsuperを呼び出す必要がない

#メソッドのオーバーライド


class Product
	attr_reader :name, :price

	def initialize(name, price)
		@name = name
		@price = price
	end

	def to_s
		"name: #{name}, price:#{price}"
	end
end

class DVD < Product
	attr_reader :running_time

	def initialize(name,price,running_time)
		super(name,price)
		@running_time = running_time
	end

	def to_s
		#superでスーパークラスのto_sメソッドを呼び出す
		"#{super}, running_time: #{running_time}"
	end
end

product = Product.new('A great movie',1000)
p product.to_s
#=> "#<Product:0x00007fa0e79157c8>"

dvd = DVD.new('An awesome film',3000,120)
p dvd.to_s
#=> "#<DVD:0x00007fa0e7915638>"

#クラスメソッドの継承
#クラスを継承するとクラスメソッドも継承される
class Foo
	def self.hello
	end
end

class Bar < Foo
end

#Fooを継承したBarでもクラスメソッドのhelloが呼び寄せる
Foo.hello #=> "hello"
Bar.hello #=> "hello"

#-- 7.7 メソッドの公開レベル --

# Rubyのメソッドには以下の3つの公開レベルがある
# public
# protected
# private

#publicメソッド
クラスの外部からでも自由に呼び出せるメソッド。
initialize以外のメソッドはデフォルトでpublicメソッドになる

privateメソッド
クラスの外からは呼び出しができず、クラス内部でのみ使えるメソッド

class User
	private
	def hello
		'Hello'
	end
end
user = User.new
#privateメソッドなのでクラスの外部から呼び出せない
user.hello #=> Error

#厳密にいうとprivateメソッドはレシーバを指定して呼び出すことができないメソッド
#user.helloと書いた場合はuserがhelloメソッドのレシーバになる。しかしhelloメソッドがprivateメソッドであればレシーバ指定できないのでuser.helloのように呼び出すとエラーになる

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
