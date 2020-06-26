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
user = User.new
user.hello #=> Error

class User
	#反対にselfなしでnameメソッドを呼び出す
	def hello
		"Hello, I am #{name}."
	end

	private

	def name
		'Alice'
	end
end
user = User.new
user.hello #=>"Hello,I am Alice"

#privateメソッドはサブクラスでも呼び出せる

class Product
	private

	def name
		'A great movie'
	end
end

class DVD < Product
	def to_s
		"name: #{name}" #nameはProdiuctのprivateメソッド
	end
end

dvd = DVD.new
dvd.to_s

class Product
	def to_s
		#nameは常に"A great movie"になるとは限らない
		"name: #{name}"
	end

	private

	def name
		'A great movie'
	end
end

class DVD < Product
	private

	#スーパークラスのprivateをオーバーライドする
	def name
		"An awesome film"
	end
end

product = Product.new
#Productクラスのnamaメソッドが使われる
product.to_s "name: A great movie"

dvd = DVD.new
#オーバーライドしたBMWクラスのnameメソッドが使われる
dvd.to_s #=>#name awesome film

#クラスメソッドをprivateにしたい場合
class User
	private

	#クラスメソッドもprivateになる？
	def self.hello
		'hello'
	end
end
#クラスメソッドはprivateにならない
User.hello #=> "Hello!"
#privateメソッドになるのはインスタンスメソッドだけ

#クラスメソッドをprivateにしたい場合は class << self のつけ忘れで不具合が発生するケース構文を使う
class User
	class << self
		#class << selfの公文ならクラスメソッドでもprivateが機能する
		private
		def hello

			'Hello'
		end
	end
end

#private_class_methodでクラスメソッドを定義後に公開レベルを変更できる
class User
	def self.hello
		'hello'
	end
	#後からクラスメソッドをprivateに変更する
	private_class_method :hello
end
User.hello #=> NoMethodError

#privateメソッドから先に定義する場合
class User
	#ここから下はprivateメソッド
	private

	def foo
	end

	#ここからしたはpublicメソッド
	public

	def bar
	end
end

#後からメソッドの公開レベルを変更する場合
class User
	def foo
		'foo'
	end

	def bar
		'bar'
	end

	#fooとbarをprivateメソッドに変更する
	private :foo, :bar

	#bazはpublicメソッド
	def baz
		'baz'
	end
end

user = User.new
user.foo #=>NOMethodError
user.bar #=>NOMethodError
user.baz #=> "baz"

#protectメソッド
class User
	#weightは外部に公開しない
	attr_reader :name

	def initialize(name, weight)
		@name = name
		@weight = weight
	end

	#自分がother_userより重たい場合はtrue
	def heavier_than?(other_user)
		other_user.weight < @weight
	end

	protected

	def weight
		@weight
	end
end
alice = User.new('Alice',50)
bob = User.new('Bob',60)
#AliceはBobの体重options取得できない
alice.heavier_than?(bob)#=> Error

#同じクラスのイオンスタントメソッドならweightが呼び出せる
bob.beavier_than?(alice)
#クラスの外では呼び出せない
alice.weight

#さらにシンプルに記述する
class User
	#一旦publicメソッドとしてweightを定義する
	attr_reader :name, :weight
	protected :weight
end

# ----- 定数についてもっと詳しく -----

#定数はクラスの外部から直接参照することも叶。クラスの外部から定数を参照する場合は
#クラス名::定数名とする

class Product
	DEFAULT_PRICE = 0
	#定数をprivateにしたい場合
	private_constant :DEFAULT_PRICE
end

Product::DEFAULT_PRICE #=> 0

#定数はメソッド内部で作成することはできない
#必ずクラス直下で作成する必要がある

class Product
	def foo
		DEFAULT_PRICE = 0
	end
end
#Error メソッド内部で作るとエラーになる

#定数と再代入
#Rubyの定数は「みんなわざわざ変更するなよ」と周りに年を押したような変数。
#そのままの状態だと定数を色々と変更できてしまう

class Product
	DEFAULT_PRICE = 0
	#再代入して定数の値を変える
	DEFAULT_PRICE = 1000
end
Product::DEFAULT_PRICE #=> 1000

#クラスの外部からでも再代入が可能
Product::DEFAULT_PRICE = 3000

Product::DEFAULT_PRICE #=> 3000

#クラスを凍結して変更できないようにする
Product.freeze
#freezeすると変更できなくなるがデメリットも大きいので普通はしない

#定数はミュータブルなオブジェクトに注意する
#ミュータブルなオブジェクトとは文字列（string）や配列（Array）、ハッシュ（hash）など

class Product
	NAME = 'A prodect'
	SOME_NAMES = ['Foo', 'bar', 'Baz']
	SOME_PRICES = {'Foo' => 1000, 'Bar' => 2000, 'Baz' => 3000}
end

#文字列をは快適に大文字にする
Product::NAME.upcase!
Product::NAME #=> "A PRODUCT"

#配列に新しい要素を追加する
Product::SOME_NAMES << 'Hope'
Product::SOME_NAMES #=>["Foo","Bar","Baz","Hoge"]

#ハッシュに新しいキーと値を追加する
Product::SOME_PRICES['Hoge'] = 4000
Product::SOME_PRICES #=>#=>["Foo"=>1000,"Bar"=>2000,"Baz"=>3000,"Hoge"=>4000]

class Product
	SOME_NAMES = ['Foo','Bar','Baz']

	def self.names_without_foo(names = SOME_NAMES)
		#freezeしている配列に対しては破壊的eetな変更はできない
		names.delete('Foo')
		names
	end
end
Product.names_without_foo #=> RuntimeError
#上記のコードでも配列やハッシュをfreezeすると配列やハッシュそのものへの変更は防止できるが配列やハッシュの各要素はfreezeしない
#以下のように1番目の要素を破壊的に大文字に変更する
Product::SOME_NAMES[0].upcase!
#1番目の要素の値が変わってしまう
Product::SOME_NAMES #=> ["FOO","Bar"."Baz"]

class Product
	#中身の文字列もfreezeされるが中身の文字列はfreezeされない
	SOME_NAMES = ['FOO'.freeze,'Bar'.freeze,' Baz'.freeze].freeze
end

#mapメソッドで書く要素をfreezeして最後にmapメソッドの戻り値を配列にfreezeする
SOME_NAMES = ["FOO","Bar"."Baz"].map(&:freeze).freeze

 ["FOO","Bar"."Baz"].map{|n| n.freeze }
 #上記のようにブロック引数が1つだけ、メソッドを呼び出す以外の処理がない、引数がないという条件を満たせば次の様にかける
  ["FOO","Bar"."Baz"].map(&:freeze).freeze

#数値やシンボル、true/falseはイミュータブルなオブジェクトなので破壊的に変更することはできないのでfreezeする必要はない

#----- 7.9 様々な種類の変数 ------

#クラスインスタンス変数
#@から始まる変数

class Prtoduct
	#クラスインスタンス変数
	@name = 'Product'
	#クラスインスタンス変数
	def self.name
		@name
	end
	#インスタンス変数
	def initialize(name)
		@name = name
	end
	#インスタンス変数
	def name
		@name
	end
end
Product.name #=> "Product"
product = Product.new('A great movie')
product.name
Product.name #=> "Product"

#インスタンス変数はインスタンスの作成とは無関係にクラス自身が保持しているデータ（クラス自身のインスタンス変数）クラス公文の直下やクラスメソッドの内部で@で始まる変数を操作するとクラスインスタンスにアクセスしていることになる。

class Prtoduct
#スーパークラス
	#クラスインスタンス変数
	@name = 'Product'
	#クラスインスタンス変数
	def self.name
		@name
	end
	#インスタンス変数
	def initialize(name)
		@name = name
	end
	#インスタンス変数
	def name
		@name
	end
#サブクラス
	def DVD < prodect
		#クラスインスタンス変数
		@name = 'DVD'
	#クラスインスタンス変数
	def self.name
		#クラスインスタンス変数を参照
		@name
	end
	#クラスインスタンス変数
	def upcase_name
		#インスタンス変数を参照
		@name.upcase
	end
end

Product.name #=> "Product"
DVD.name #=> DVD

product = Product.new('A great movie')
product.name #=> "A great"movie"

dvd = DVD.new('An awesome film')
dvd.name  #=> "An awesome FILM"
dvd.upcase_name #=> AN AWESOME FILM

Product.name #=> "Product"
DVD.name #=> "DVD"

# クラス変数

#クラス変数は変数の最初に@を2つ重ねる
class Product
	@@name

	def self.name
		@@name
	end

	def name
	end
end

class DVD < Product
	@@name = 'DVD'

	def self.name
		@@name
	end

	def upcase_name
		@@name.upcase
	end
end

#DVDクラスを定義したタイミングで@@nameが”DVD"に変更される
Product.name #=>"DVD"
DVD.name #=>"DVD"

product = Product.new('A great movie')
product.name #=> "A great movie"

#Product.newのタイミングで@@nameが"A great movie"に変更される
Product.name #=> "A great movie"
DVD.name #=>"A great movie"

dvd = DVD.new("An awesome film")
dvd.name #=> "An awesome film"
dvd.upcase_name #=>"AN AWESOME FILM"

#DVD.newのタイミングで@@nameが"An awesome film"に変更される
product.name #=> "An awesome film"
Product.name #=> "An awesome film"
DVD.name #=> "An awesome film"

#クラス変数の@@nameはクラスメソッド内でもインスタンスメソッド内でも共有されている

#グローバル変数と組み込み変数

# $some_valueの様に$で変数名を始める

#グローバル変数の宣言と値の代入
$program_name = 'Awesome program'

#グローバル変数に依存するクラス
class Program
	def initialize(name)
		$program_name = name
	end

	def self.name
		$program_name
	end

	def name
		$program_name
	end
end

#$program_nameは既に名前が代入されている
Program.name #=>"Awesome program"

program = Program.new('Super program')
program.name #=> "Super program"

#Program.newのタイミングで$program_nameが”Super program"に変更される
Program.name #=> "Super program"
$program_name #=> "Super program"

# ----- 7.10 クラス定義やRubyの言語使用に関する高度な話題 ------

#エイリアスメソッドの定義
#別名でも全く同じ動作をするエイリアスメソッド（別名メソッド）
#Stringクラスのsizeメソッドとlengthメソッドなどはエイリアスメソッド

#独自に作成したクラスでもエイリアスメソッドを定義することができる
#alias 新しい名前 元の名前
class Usr
	def hello
		'Hello!'
	end

	# helloメソッドのエイリアスメソッドとしてgreeetingを定義する
	alias greeting hello
end

user = User.new
user.hello #=> "Hello!"
user.greeting #=>"Hello!"

#メソッドの削除
#undef 削除するメソッドの名前

class User
	#freezeメソッドの定義を削除する
	undef freeze
end
user = User.new
#freezeメソッドを呼び出すとエラーになる
user.freeze #=>NoMethodError

#ネストしたクラスの定義

# class 外側のクラス
# 	class 内側のクラス
# 	end
# end

#クラスの内部に定義したクラスは次の様に::を使って参照できる
#外側にクラス ::内側のクラス
class User
	class BloodType
		attr_reader :BloodType

		def initialize(type)
			@type = type
		end
	end
end

blood_type = User::BloodType.new('B')
blood_type.type

#この手法はクラス名の予期せぬ衝突を防ぐ「名前空間（ネームスペース）」を作る場合によく使われる。
#ただし名前空間を作る場合はクラスよりもモジュールが使われることが多い

#クラスの可視性について
#プログラミング言語によってはメソッドだけでなくeetクラスに対してもpublicやprivateの様な可視性を設定できるものがある。
#Rubyではクラス構文にpublicやprivateの様なキーワードをつけることはできない。

# class User
# 	#この様なクラス定義はエラーになる
# 	private class BloodType
# 	 #省略
# 	end
# end

#演算子の挙動を独自に再定義する

class User
	# =で終わるメソッドを定義する
	def name=(value)
		@name = value
	end
end

user = User.new
#変数に代入する様な形式でname=メソッドを呼び出せる
user.name = 'Alice'

# ==を再定義する
class Product
	attr_reader :code, :name

	def initialize(code,name)
		@code = code
		@name = name
	end

	#==を再定義(オーバーライド)する
	#以下のコードがないとスーパークラスのObjectクラスでは、==はobject_idが一致したときにtrueを返すという仕様になっているためfalseで返してしまう
	def ==(other)
		if other.is_a?(Product)
			#もし商品コードが一致すれば同じProductとみなす
			code == other.code
		else
			#oherがProductでなければ常にfalse
			false
		end
	end
end

#aとcが同じ商品コード
a = Product.new('A-0001', 'A great movie')
b = Product.new('B-0001', 'A awesome movie')
c = Product.new('A-0001', 'A great movie')

# ==がこの様に動作して欲しい
p a == b #=>false
p a == c #=>true

#Product以外の値はfalse
a == 1
a == 'a'

#奇妙だが==をメソッドにしているの.をつけても正常に呼び出せる
a.==(b)
a.==(c)

# ==が呼び出されるのは左辺のオブジェクトなので次の様に書くとProductクラスの==ではなくてIntegerクラスの==が呼び出される
1 == a

#等値を判断するメソッドや演算子を理解する
equal?
==
erl?
===

#eqal?メソッド
#object_idが等しい場合にtrueを返す
a = 'abc'
b = 'abc'
a.equal?(b) #=>false
c = a
a.equal?(c) #=>true

#==
#==はオブジェクトの内容が等しいかどうか判断する。
1 ==1.0 #=>true

#eql?
# # eql?はハッシュのキーとして2つのオブジェクトが等しいかどうかを判断する。
# # ==では等値と皆してもハッシュのキーとしては異なる値として扱いたい場合はeql?メソッドにその要件を定義する
# ハッシュ上では1と1.0は別々のキーとして扱われる
h = { a => 'Integer', 1.0 => 'Float'}
h[1]
h[1.0]

#異なるキーとして扱われるのはeql?メソッドで比較したときにfalseになるため
1.eql?(1.0) #=>false

#eql?メソッドを再定義した場合は「a.eql?(b)が真なら、a.hash == b.hashも真」となる様にhashメソッドも再定義しなければならない
a = 'japan'
b = 'japan'
a.eql?(b)
p a.hash
p b.hash

c = 1
d = 1.0
c.eql?(d)
p c.hash
p d.hash

#===

#===は主にcase文のwhen節で使われる。例えばcase文では正規表現を使って次の様な条件がかける
text = '03-1234-5678'

case text
when /^\d{3}-\d{4}$/
	puts '郵便番号です'
when/^\d{4}\/\d{1,2}\/\d{1,2}$/
	puts '日付です'
when /^\d+-\d+-\d+$/
	puts '電話番号です'
end

#このコードを実行すると内部的には
/^\d{3}-\d{4}$/ === text
/^\d{4}\/\d{1,2}$/ === text

# "when節のオブジェクト === case節のオブジェクト"の結果を評価している
# StringクラスやArrayクラスもClassクラスのインスタンスであり、Classクラスは===を再定義しているので次の様なcase文を書いてオブジェクトのデータ型（所属するクラス）を識別できる

value = [1,2,3]

#内部的にはstring === value, Array ===value, Hash ===value の結果が評価されている
case value
when String
	puts '文字列です'
when Array
	puts '配列です'
when Hash
	puts 'ハッシュです'
end
#=>配列です

#-- オープンクラスとモンキーパッチ--
#Rubyの継承には制限がない。StringクラスやArrauクラスなど組み込みライブラリのクラスであっても継承して独自のクラスを定義することができる

#Stringクラスを継承したドキ図クラスを定義する
class MyString < String
	#Stringクラスを拡張するためのコードを書く
end
s = MyString.new('hello')
s #=> 'Hello'
s.class #=> "String"
class MyArray.new()
	#Arrayクラスを拡張するためのコードを書く
end
a = MyArray.new()
a << 1
a << 2
a #=> [1,2]
a.class #=> MyArray

class String
	def shuffle
		chars.shuffle.join
	end
end

s = 'Hello, I am Alice.'
s.shuffle #=>"cill m,AHeea l I.o"

#Railsでの独自メソッド
#文字列をキャメルケースからスネークケースへ変換する
'MyString'.underscore #=>my_string

#レシーバが杯数の配列に含まれていればtrueを返す
numbers = [1,2,3]
2.in?(numbers) #=>true
5.in?(numbers) #=> false

#モンキーパッチ（既存のメソッドの上書き）を当てる
class User
	def initialize(name)
		@name = name
	end

	def hello
		"Hello,#{@name}!"
	end
end
	#モンキーパッチを当てる前の挙動を確認する
	user = User.new('Alice')
	user.hello #=> "Hello,Alice!"

	#helloメソッドにモンキーパッチを当てて独自の挙動を持たせる
	class User
		def hello
			"#{@name}さん、こんにちは！"
		end
	end

	user.hello #=> "Aliceさん、こんにちは!"

#応用バージョン
#既存のメソッドをエイリアスメソッドとして残し、上書きしたメソッドの中で既存のメソッドを再利用する
class User
	def initialize(name)
		@name = name
	end

	def hello
		"Hello, #{@name}!"
	end
end

#モンキーパッチをあたるためにUserクラスを再オープンする
class User
	#既存のhelloメソッドはhello _originalとして呼び出せる様にしておく
	alias hello_original hello

	#helloメソッドにモンキーパッチを当てる（もともと実装されていたhelloメソッドも再利用する）
	def hello
		"#{hello_original}じゃなくて、#{@name}さん、こんにちは！"
	end
end


user = User.new('tarou')
p user.hello #=>"Hello, tarou!"
p user.hello_original #=>"Hello, tarou!じゃなくて、tarouさん、こんにちは！"

#特異メソッド
#Rubyではクラス単体ではなくオブジェクト単体でも挙動を変えることができる
alice = 'I am Alice'
bob = 'I am Bob'

#aliceのオブジェクトにだけ、shuffleメソッドを定義する
def alice.shuffle
	chars.shuffle.join
end

#Aliceはshuffleメソッドを持つがbobは持たない
alice.shuffle #=>#=> "m le a.icIA"
bob.shuffle #=> NoMethodError

#これは先に作成した変数の'alice'に対して、alice.shuffleというメソッドを定義しているから。
#この様に特定のオブジェクトだけに紐づくメソッドのことを特異メソッドと呼ぶ(英語ではsingletonクラス、eigenクラス)
#数値やシンボルに対してはRubyの制約により特異メソッドを定義できない

n = 1
def n.foo
	'foo'
end
#=> TypeError: can't define singleton

sym = :alice
def sym.bar
	'bar'
end
#=>Type Error:can't define singleton

#次の様な方法で特異メソッドを定義できる
alice = 'I am Alice'
class << alice
	def shuffle
		chars.shuffle.join
	end
end
alice.shuffle #=> #=> " ci Ama.lIe"

#クラスメソッドは特異メソッドの一種

#クラスメソッドを定義するコード例
class User
	def self.hello
		'Hello'
	end

	class << self
		def hi
			'Hi.'
		end
	end
end

#特異メソッドを定義するコード例
alice = 'I am Alice'

def alice.hello
	'Hello.'
end

class << alice
	def hi
		'Hi.'
	end
end

#特異メソッドをイメージしやすいクラスメソッドの定義方法
class User
end
	#クラス構文の外部でクラスメソッドを定義する方法1
	def User.hello
		'Hello'
	end

	#クラス構文の外部でクラスメソッドを定義する方法2
	class << Userdef hi
		'Hi.'
	end
end

User.hello #=> "Hello"
User.hi #=> "Hi."

#正式な表現、説明
#RubydehaStringやUser の様なクラスもオブジェクトなので、クラスに特異メソッドを定義するとクラスメソッドの様に見えるというのが正確な説明。

# ダックタイピング
# 静的型付け言語には抽象クラスやインターフェイスといった機能があるが、Rubyの様な動的型付言語ではない。
# 静的型付け言語では実行前にそのメソッドが100％確実に呼び出せることを保証しようとする。そのためコンパイル時にオブジェクトのデータ型をチェックし特定のクラスを継承していたり、特定のインターフェイスを実行しようとしていたりすればメソッドの呼び出しは可能、そうで無ければNGと判断する。
# 動機付け型言語では実行時にそのメソッドが呼び出せるかどうかを判断し、呼び出せない時はエラーが起きるRubyが気にするのは
# 「コードを実行するその瞬間にそのメソッドが呼び出せるか否か」であり
# 「そのオブジェクトのクラス（データ型）が何か」ではない。

def desplay_name(object)
	puts "Name is << #{object.name}>>"
end
#上記のメソッドは引数で渡されたオブジェクトがnameメソッドを持っていること(object.nameが呼び1出せること)を期待している。
#それ以外のことは何も気にしないので以下の様に全く別々のオブジェクトを渡すことができる
class User
	def name
		'Alice'
	end
end

class Product
	def name 'A great movie'
	end
end


#UserクラスとPriductクラスはお互いに無関係なクラスだが、displeayUserfileメソッドは何も気にしない
user = User.new
display_name(user) #=>Name is <<Alice>>

product = Product.new
display_name(product) #=>Name is << A great movie>>

#この様にオブジェクトのクラスが何であろうとメソッドが呼び出せれば良しとするプログラミングスタイルを「ダックタイピング」と呼ぶ。
class Product
	def initialize(name,price)
		@name = name
		@price = price
	end

	def display_text
		stock = stock? ? 'あり' : 'なし'
			"商品名: #{@name} 価格: #{@price}円 在庫: #{stock}"
	end
end

class DVD < Product
		def stock?
			true
		end
	end
end

product = Product.new('great',1500)
# p product.display_text # NoMethodError

dvd = DVD.new('awesome',2000)
p dvd.display_text #=>"商品名: awesome 価格: 2000円 在庫: あり"

# Rubyが気にするのは「stock?」メソッドが呼び出せるかどうか
#動的型付け言語は事前に実行可能なコードかどうかを検証しないため、当然ながら実行して初めてエラーかどうかわかる

#メソッドの有無をしたベルrespond_to?

オブジェクトのクラスを確認する場合は
instance_of?メソッドやis_a?メソッドを使えるが
オブジェクトに対して特定のメソッドが呼び出し可能か確認する場合はrespond_to?メソッドを使う
s = 'Alice'

#Stringクラスはsplitメソッドを持つ
s.respond_to?(:split) #=>true

#nameメソッドは持たない
s.respond_to?(:name)

#オブジェクトが呼び出したいメソッドを持っているかどうかで条件分岐
class Object

	def display_name(object)
		if object.respond_to?(:name)
			puts "Name is <<#{object.name}>>"
		else
			puts "No name."
		end
	end
end

	s = 'Alice'
	s.respond_to?(:split) #=>true
	p s.display_name(s)

	n = "Riu"
	n.respond_to?(:name)
	p display_name(n)


#Rubyでメソッドのオーバーロード？
静的型付け言語ではメソッドのオーバーロード（多重定義）という機能があり、これは引数ので9 田型雨あ個数の違いに応じて同じ名前のメソッドを複数う定義できる
Rubyには同じ機能はないため、あるメソッドが数値だけでなく文字列やnilも引数として受け取られる様にしたいという場合は
is_a?メソッドで引数のクラスをチェックしたり、to_iメソッドで明示的に数値に変換すればオーバーロードと同じ様な仕組みが作れる

def add_ten(n)
	#nが整数以外の場合にも対応するためto_iで整数に変換する
	n.to_i + 10
end

#整数を渡す
add_ten(1)

#文字列やnilを渡す
add_ten('2') #=>12
add_ten(nil) #=>10

#引数のデフォルトに値をつける
def add_numbers(a = 10,b = 0)
	a + b
end

#引数の個数はゼロでも1個でも2個でも良い
p add_numbers #=>0
p add_numbers(1)
p add_numbers(1,2)
p add_numbers(1,5)

#上記の様にRubyは1つのメソッドでいろいろなデータ型ちゃ個数の引数を受け取ることができるため、同じ前で複数のメソッド定義を持つ必要がなくオーバーロードという考え方も必要ない







