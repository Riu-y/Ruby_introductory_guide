例外処理を理解する

# ----- 9.2 例外の補足 -----

#発生した例外を補足する

begin 
	#例外が起きうる処理
rescue
	#例外が発生した場合の処理
end


puts 'Start'
module Greeter
	def hello
		'hello'
	end
end

# greeter = Greeter.new
#  #上の行で例外が発生するためこここからしたは実行されない
#  puts 'End'
begin
	greeter = Greeter.new
rescue
	puts '例外が発生したが、このまま続行する'
end

puts 'END'

#例外処理の流れ
#例外が発生した箇所から少し離れた箇所で例外を補足するコード

# method_1にだけ例外処理を記述する
def method_1
	puts 'method_1 start.'
	begin
		method_2
	rescue
		puts '例外が発生しました'
	end
	puts 'method_1 end.'
end

def method_2
	puts 'method_2 start.'
	method_3
	puts 'method_2 end.'
end

def method_3
	puts 'method_3 start.'
	1 / 0
	puts 'method_3 end.'
end

#処理を開始する
method_1
#=> method_1 start.
#=> method_2 start.
#=> method_3 start.
#=> 例外が発生しました
#=> method_1 end.

#例外オブジェクトから情報を取得する
#Rubyでは発生した例外自身もオブジェクトになっている。そのためオブジェクトを呼び出すことで発生した例外に間んする情報を取得できる
begin
	#例外が起きる処理
rescue #=> 例外オブジェクトを格納する変数
 # 例外が発生した場合の処理
end

begin
	1 / 0
rescue => e
	puts "エラークラス:#{e.class}"
	puts "エラーメッセージ: #{e.message}"
	puts "バックトレース -----"
	puts e.backtrace
	puts "----"
end

#クラスをしてして補足する例外を限定する

begin
	#例外が起きうる処理
rescue 補足したい例外クラス
	#例外が発生した場合の処理
end

begin
	1 / 0
rescue ZeroDivisionError
	puts "0で除算しました"
end
#=> 0で除算しました。
#ZerodivisionErroのみに対応するrescue処理。それ以外の例外は補足されない

#rescue節を複数書くことで異なる例外クラスに対応することもできる
begin
	'abc'.foo
rescue ZeroDivisionError
	puts "0で除算しました"
rescue NoMethodError
	puts "存在しないメソッドが呼び出されました"
end

#次の様に、例外オブジェクトを変数に格納することも可能
begin 
	'abc'.foo
rescue ZeroDivisionError, NoMethodError =>e
	puts "0で除算したか、存在しないメソッドが呼び出されました"
	puts "エラー: #{e.class} #{e.message}"
end

#例外クラスの継承関係を理解する
rescue節で例外クラスを指定する場合はRubyにおける例外クラスの継承関係を理解しておく必要がある。
rescue節に何もクラスを指定しなかった場合に補足されるのはStandardErrorとそのサブスクライブのみ
NoMemoryErrorやSystemExitなどStandardErrorを継承していない例外クラスは補足されない

#例外処理の悪い例
begin 
	#例外が起きそうな処理
rescue Exception
	#Exceptionとそのサブクラスが補足される、
end

#継承関係とrescue節の順番に注意する
begin
	# NoMethodErrorを発生させる
	'abc'.foo
rescue NameError
	#NoMet hodErrorはここで補足される
	puts 'NameErrorです'
rescue NoMethodError
	#このrescue節は永遠に実行されない
	puts 'NoMethodErrorです'
end

#NameErrorはNoMet hodErrorのスーパークラスなのでNameErrorクラスを指定した最初のrescue節で補足される。
この問題を解決するためにはクラスの順番を入れ替える。
begin
	'abc'.foo
rescue NoMethodError
	"NoMethodErrorはここで補足される"
	puts 'NameErrorです'
rescue NameError
	"NameErrorです"
	puts "NameErrorです"
end

#また次の様にStandartErrorクラスをしてすれば通常のプログラミングで発生するその他のエラーをまとめて補足することができる
begin
	#ZeroDivisionErrorを発生させる
	1 / 0
rescue NoMethodError
	puts 'NoMethodError'
rescue NameError
	puts 'NameError'
rescue 'StandardError'
	puts 'その他のエラーです'
end

#そもそもクラスをしなくても良い
begin
	#ZeroDivisionErrorを発生させる
	1 / 0
rescue NoMethodError
	puts 'NoMethodError'
rescue NameError
	puts 'NameError'
rescue #例外クラスを指定しない
	puts 'その他のエラーです'
end

#例外発生事に処理をもう一度やり直すretry
#無条件にretryし続けると例外が解決しない婆に無限ループを作ってしまう恐れがあるのでretryの回数を制限する
retry_count = 0
begin
	puts '処理を開始します。'
	#わざと例外を発生させる
	1 / 0
rescue
	retry_count += 1
	if retry_count <= 3
		puts "retryします。（#{retry_count}回目)"
		retry
	else
		puts 'retryに失敗しました'
	end
end

# ----- 9.3意図的に例外を発生させる -----

#raise処理を使って意図的に例外を発生させる
def currency_of(country)
	case country
	when :japan
			'yen'
	when :us
		'dollar'
	when :india
		'rupee'
	else
		raise
	end
end
currency_of(:italy) #=> RuntimeError
# raiseメソッドに文字列だけを渡したときはRuntimeErrorクラスの例外が発生する
# 第2引数にエラーメッセージを渡すとRuntimeErrorクラス以外の例外クラスで例外を発生させられる

def currency_of(country)
	case country
	when :japan
		'yen'
	when :us
		'dollar'
	when :india
		'rupee'
	else
		raise ArgmentError, "無効な国名です。#{country}"
	end
end
currency_of(:italy) #=>ArgmentError: 無効な国名です。italy

#またはraiseメソッドに例外クラスのインスタンスを渡す方法もある
def currency_of(country)
	case country
	when :japan
		'yen'
	when :us
		'dollar'
	when :india
		'rupee'
	else
		raise ArgmentError.new("無効な国名です。#{country}")
	end
end
currency_of(:italy) #=>ArgmentError: 無効な国名です。italy

# ----- 9.4 例外のベストプラクティス ------

# 安易にrescueを使わない

#rescueしたら情報を残す
	#最低でも例外が発生したクラス名、エラーメッセージ、バックトレースの3つやログはターミナルに出力すべき

	#イメージコード
	user.each do |user|
		begin
			#メールを送信する
			send_mail_to(user)
		rescue =>e
			#例外のクラス名、エラーメッセージ、バックトレースをターミナルに出力
			#（ログファイルがあればそこに出力する方がベター）
			puts "#{e.class}: #{e.message}"
			puts e.backtrace
		end
	end

#例外処理の対象範囲と対象クラスを極力絞り込む

require 'date'
 #平成の日付文字列をDateオブジェクトに変換する
def convert_heisei_date(heisei_text)
	begin
		#以下は例外対象の領域が無駄に広すぎるので良くない
		m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
		year = m[:jp_year].to_i + 1988
		month = m[:month].to_i
		day = m[:day].to_i
		Date.new(year, month, day)
	rescue
		#例外が起きたら（無効な日付が渡されたら）nilを返したい
		nil
	end
end

def convert_heisei_to_date(heisei_text)
	m = heisei_text.match(/平成(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/
	year = m[:jp_year].to_i + 1988
	month = m[:month].to_i
	day = m[:day].to_i
	#例外処理の範囲を狭め、補足する例外クラスを限定する
	begin
		Date.new(year, month, day)
	rescue ArgumentError
		#無効な日付であればnilを返す
		nil
	end
end


#例外処理よりも条件分岐を使う

require 'date'

def convert_heisei_to_date(heisei_text)
	m = heisei_text.match(/平成(?<jp_yaer>\d)年(?<month>\d+)月(?<day>\d+)日/)
	year = m[:jp_year].to_i + 1988
	month = m[:month].to_i
	day = m[:day].to_i
	#正しい日付の場合のみ、Dateオブジェクトを作成する
	if Date.valid_date?(year, month, day)
		Date.new(year, month, day)
	end
end

#予期しない条件は異常終了させる
def currency_of(country)
	case country
	when :japan
		'yen'
	when :us
		'dollar'
	when :india
		'rupee'
	else
		raise ArgumentError, "無効な国名です。#{country}"
	end
end

currency_of(:italy) #=>ArgumentError: 無効な国名です。italy

#----- 9.5 正規表現チェッカープログラムの作成 -----

#文字入力を受け付けるgetsメソッド
input = gets
#Helloと入力してからリターンキーを押す
input #=> "Hello\n"

input = gets
#Helloと入力してからリターンキーを押す
input = input.chomp
input #=> "Hello"

#短縮する
input = gets.chomp

print "Text?:"
text = gets.chomp

begin
	print "Pattern?:"
	pattern = gets.chomp
	regexp =Regexp.new(pattern)
rescue RegexpError => e
	puts "不正な数値です。#{pattern}"
	retry
end

matches = text.scan(regexp)
if matches.size > 0
	puts "Matched: #{matches.join(' , ')}"
else
	puts "Nothing mached."
end



#----9.6 例外処理に関してもっと詳しく -----
#ensure
例外処理を入れた場合、例外が発生してもしなくても必ず実行したい処理が出てくる場合がある。
そんな場合は例外処理にensure節を加えることで必ず実行される処理を実行されることができる。ensure説の書き方は以下eetの通り
begin
	# 例外が発生するかもしれない処理
rescue
	#例外発生事の処理
ensure
	#例外の有無にかかわらず実行する処理
end

rescue節は必須ではない。異常終了しても良いが、終了する前に必ず実行したい処理があるという場合は次の様にensure説だけを書くことも可能。

begin
	#例外が発生するかもしれない処理
ensure
	#例外の有無にかかわらず実行する処理
end

file = File.open('some.txt','w')

begin
	#ファイルに文字列を書き込む
	file << 'Hello'
ensure
	#例外の有無に関わらず必ずファイルをクローズする
	file.close
end

#ensureの代わりにブロックを使う

#ファイルの読み書きを行うな愛はopenメソッドにブロックを渡すことで済む
#ブロック付きでオープンすると、メソッドの実行後に自動的にクローズされる
File.open('some.text','w') do |file|
	file << 'Hello'
end

#もしブロックの実行中に例外が発生した場合もopenメソッドが必ずクロージ処理を実行してくれる
File.open('some.txt','w') do |file|
	file << 'Hello'
	1 / 0
end
#例外は発生するもののopenメソッドによってクローズ処理自体は必ず行われる

#ensure説を書く前にAPIドキュメントで便利な機能がないか確認するべき

#例外処理のelse

begin
	#例外が発生するかもしれない処理
rescue
	#例外が発生した場合の処理
else
	#例外が発生しなかったときの処理
ensure
	#例外の有無に関わらず実行する処理
end

#begin節に例外が発生しなエクセントリック婆の処理を書いて仕舞えばelse節を書かなくても問題ないことが多い

#else節を使う場合
brgin puts 'Hello.'
rescue
	puts'例外が発生しました。'
else
	puts '例外は発生しませんでした。'
end
#else節を使わない場合
begin
	puts 'Hello.'
	puts '例外は発生しませんでした。'
rescue
	puts '例外が発生しました。'
end

#例外処理と戻り値
# 例外が発生せずに最後まで正常に処理が進んだ場合はbegin節の最後の式が戻り値になる。
# また例外が発生してその例外が捕捉された場合はrescue節の最後の式が戻り値になる

#正常に終了した場合
ret =
	begin
		'OK'
	rescue
		'error'
	ensure
		'ensure'
end
ret #=> OK

#例外が発生した場合
ret =
	begin
		1 / 0
	rescue
		'error'
	ensure
		'ensure'
	end
ret #=> error

def some_method(n)
	begin
		1 / n
		'ok'
	rescue
		'error'
	ensure
		'ensure'
	end
end

#ensure節ではreturnを使わない
def some_method(n)
	begin
		1 / 0
		'OK'
	rescue
		'error'
	ensure
		#ensure説にreturnを書く
		return 'ensure'
	end
end

some_method(1)
some_method(0)
#正常事も例外発生事もensureの値がメソッドの戻り値になってしまう

def some_method(n)
	begin
		1 / 0
		'OK'
	ensure
		#ensure説にreturnを書く
		return 'ensure'
	end
end
#さらにrescue説を消してensure節だけにすると例外の発生自体が取り消されてしまう
# つまり正常終了してしまう

begin/endを省略するrescue修飾子
#rescueは修飾子としても使うことができる
例外が発生しそうな処理 rescue 例外が発生したときの戻り値

#例外が発生しない場合
1 / 1 rescue 0 #=> 1

#例外が発生する場合
1 / 0 rescue 0 #=> 0

require 'date'

def to_date(string)
	begin
		#文字列のバースを試みる
		Date.parse(string)
	rescue ArgumentError
		#パースできない場合はnilを返す
		nil
	end
end
#パース可能な文字列を渡す
to_date('2017-01-01') #=> 2017-01-01 ((2457755j,0s,0n),+0s,2299161j)>
#パース不可能な文字列を渡す
to_date('abcdef') #=> nil

$!と＄＠に格納される例外情報

begin
	1 / 0
rescue => e
	puts "#{e.class} #{e.message}"
	puts e.backtrace
end
#=> ZeroDivisionError
#組み込み変数の$!と＄＠に格納された例外情報を使う
begin
	puts "#{$!.class} #{$!.message}"
	puts $@
end

#例外処理のbegin/endを省略できるケース
def fizz_buzz(n)
	begin
		if n % 15 == 0
			'Fizz Buzz'
		elsif n % 3 == 0
			'Fizz'
		elsif n % 5 == 0
			'Buzz'
		else
			n.to_s
		end
	rescue => e
		puts "#{e.class} #{e.message}"
	end
end
fizz_buzz(nil)
#=> NoMethodError undefined method `%' for nil:NilClass

#上記の場合bginとendを省略できる。
def fiz_buzz(n)
if n % 15 == 0
	'Fizz Buzz'
elsif n % 3 == 0
	'Fizz'
elsif n % 5 == 0
	'Buzz'
else
	n.to_s
end
rescue => e
	puts "#{e.class} #{e.message}"
end

#rescueした例外を再度、発生させる
#rescue説の中でraiseメソッドを使うこともできる。この時にraiseメソッドの引数を省略するとrescue節で捕捉した例外をもう一度発生させることができる

def fizz_buzz(n)
	if n % 15 == 0
		'Fizz_Buzz'
	elsif n % 3 == 0
		'Fizz'
	elsif n % 5 == 0
		'Buzz'
	else
		n.to_s
	end
rescue => e
#発生した例外をログやメールに残す（ここはputsで代用）
puts "[LOG]エラーが発生しました #{e.class} #{e.message}"
#捕捉した例外を再度発生させ、プログラム自体は異常終了させる
	raise
end

#--  独自の例外クラスを定義する --

#例外は独自に定義することも可能。例外クラスを定義する場合は特別な理由がない限りStandardErrorクラスかそのサブクラスを継承する

class NoCountryError < StandardError
	puts "無効な国名です"
end

def currency_of(country)
	case country
	when :japan
		'yen'
	when :us
		'dollar'
	else
		#独自に定義したNoCountryErrorを発生させる
		raise NoCountryError,"#{country}"
	end
end
currency_of(:italy)

#独自のメソッドや独自の属性を追加することも可能

class NoCountyError < StandardError
	#国名を属性として取得できる様にする
	attr_reader :country

	def initialize(message, county)
		@country = country
		super("#{message} #{country}")
	end
end

def currency_of(country)
	case country
	when :japan
		'yen'
	when :us
		'dollar'
	when :india
		'rupee'
	else
		#NoCountryErrorを発生させる
		raise NoCountryError.new('無効な国名です', country)
	end
end

begin
	currency_of(:italy)
rescue NoCountryError => e
	#エラーメッセージと国名を出力する
	puts e.message
	puts e.country
end



