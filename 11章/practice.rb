#11章 Rubyのデバックを身に着ける

エラー文章
# NameError: undefined local variable or method `distanse' for #<Gate:0x007fa4ce148320 ュ @name=:mikuni>
# Did you mean? distance
# /(プログラムのパス)/lib/gate.rb:36:in `calc_fare' /(プログラムのパス)/lib/gate.rb:26:in `exit' test/gate_test.rb:33:in `test_juso_to_mikuni'`
# #バックトレースの読み方
#  NameError: undefined local variable or method `distanse' for #<Gate:0x007fa4ce148320 ュ @name=:mikuni>

#  NameError は例外クラス名
#  undefined〜がエラーメッセージ

# 以下の箇所をバックトレースと言い、プログラムが実行されてエラーが発生するまでのメソッドの呼び出しの順番

# /(プログラムのパス)/lib/gate.rb:36:in `calc_fare' /(プログラムのパス)/lib/gate.rb:26:in `exit' test/gate_test.rb:33:in `test_juso_to_mikuni'

# 上に行くほどエラーに近く、下に行くほど遠い
# なので一番うえのパスから確認していく。

# 上の行は大きく分けて3つになる
# ・ /( プログラムのパス )/lib/gate.rb
# ・36
# ・in `calc_fare'
# パスの36行目の`calc_fare`でエラーが

# プログラムが以下のような順番で呼び出されたことがわかる

# ・ gate_test.rb の 33 行目(test_juso_to_mikuni メソッド)が呼ばれた。
# ・ gate.rb の 26 行目(exit メソッド)呼ばれた。
# ・ gate.rb の 36 行目(calc_fare メソッド)が呼ばれた。

# # 11.3よく発生する例外ミス

NameError

NoMethodError

・ 単純にメソッド名を打ち間違えた。
・ レシーバの型(クラス)が想定していた型と異なる(文字列ではなくシンボルになっていた場合など)。
・ レシーバが想定に反して nil になっている。
レシーバがnilになっているケースはよく起きる。

 TypeError
・TypeError は期待しない型(クラス)がメソッドの引数に渡されたときに発生する

ArgumentError
・ArgumentError は引数(argument)の数が違ったり、期待する値ではなかったりした場合に発生
引数が必須なのに、[1, 2, 3].deleteのように引数なしでメソッドを呼んだ場合 ArgumentError: wrong number of arguments (given 0, expected 1)

ZeroDivisionError
・ZeroDivisionError は整数を 0 で除算(割り算)しようとしたときに発生

SystemStackError
システムスタックが溢れたときに発生。とくに間違ってメソッドを再帰呼び出しした場合に発生。
以下は間違ってメソッドを再帰呼び出ししたために、無限ループしてしまうコード例。

class User
# 省略  
# def name=(name)のように書くつもりがうっかり書き間違えた 
def name
# 右辺のnameは引数や変数ではなく、このnameメソッド自身になるので無限ループする 
	@name = name
	end
end
user = User.new
user.name #=> SystemStackError: stack level too deep

LoadError
・require や load の実行に失敗したときに発生。
 
・ require したいファイルのパスやライブラリ名が間違っている。 ・ require した gem が実行環境にインストールされていない。

 SyntaxError(syntax error)
  構文エラー。たいていの場合、プログラムの起動自体に失敗する。このエラーが発生したときは end やカンマの数に過不足がある、丸括弧や中括弧がちゃんと閉じられていない、といった原因が考えられる。
# 以下のコードはassert_equal({ 'japan' => 'yen' }, currencies)のように丸括弧が必要 assert_equal { 'japan' => 'yen' }, currencies
#=> test/deep_freezable_test.rb:15: syntax error, unexpected =>, expecting '}' # assert_equal { 'japan' => 'yen' }, currencies

# 11.4 プログラムの途中経過を知る
print デバック

def to_hex(r ,g ,b)
	[r, g, h].inject('#') do |hex, n|
		#変数(ブロック引数)の中身をターミナルに出力する
		puts hex
		hex + n.to_s(16).rjust(2, '0')
	end
end

def greeting(country)
	#greetingメソッドが呼ばれたことを確認
	puts 'greeting start.'
	return 'countryを入力してください' if country.nil?

	if country == 'japan'
		puts 'japan'
	else
		puts 'other'
		'hello'
	end
end

putsとpの使い分け
pメソッドは引数がそのまま戻り値になる
putsメソッドは戻り値がnilになる

def calc_fare(ticket)
	from = STATIONS.index(ticket.stamped_at)
	to = STATIONS.index(@name)
	# to - fromの結果をターミナルに出力しつつ、変数distanceに代入する
	distance = p to - from
	FARES[distance - 1]
end

tapでメソッドチェーンをデバックする

a = 'hello'.tap { |s| puts "<<#{s}>>" }

a #=> "hello"

'#043c78'.scan(/\w\w/).map(&:hex)

'#043c78'.scan(/\w\w/).tap{ |rgb| p rgb }.map(&:hex)

#ログにデバック情報を出力する

#デバックを使う

#---11.5 汎用的なトラブルシューティング方法----

irb 上で簡単なコードを動かしてみる

 $ irb
[1, 2, 3].map{¦n¦ n * 10} => [10, 20, 30]











