#----- 5.1 イントロダクション -----


#----- 5.2 ハッシュ -------

#（構文）ハッシュリテラル

{}.class #=> Hash

{ 'japan' => 'yen', 'us' => 'dollar','india'=>'rupee' }

{
	'japan' => 'yen',
	'us' => 'doller',
	'india' => 'rupee'
}

{
	'japan' => 'yen',
	'us' => 'dollar',
	'india'=>'rupee', #最後にカンマがついてもエラーにならない
}

#同じキーが出てきた場合には、最後に出てきた値が有効になる
{ 'japan' => 'yen','japan' => '円' }

[1.2.3].each {|n| puts n}

currencies = {'japan'=>  'yen', 'us'=> 'dollar','india'=> 'rupee' }
#新しいの値を追加する
currencies['italy'] = 'euro'
currencies = {'japan'=>  'yen', 'us'=> 'dollar','india'=> 'rupee' ,'italy'=>'euro'}

currencies = {'japan'=>  'yen', 'us'=> 'dollar','india'=> 'rupee' }
#既存の値を上書きするcurrencies #=>{"japan"=>"円" }

currencies = {'japan'=> 'yen','us'=>'dollar','india'=> 'rupee'}
currencies['india'] #=>'rupee'
 #存在しない場合はnilを返す
 currencies['brazil'] #=> nil


#ハッシュをつかった繰り返す処理
currencies = {'japan' =>'yen', 'us'=>'dollar','india'=> 'rupee' }
currencies.each do |key, value|
	puts "#{key} : #{value}"
end
# japana : yen
# us : dollar
# india : rupee

#ブロック引数を1つにするとキーと値が配列に格納される
currencies = { 'japan' =>'yen', 'us'=> 'dollar','india'=> 'rupee'}

currencies.each do |key_value|
	key = key_value[0]
	value = key_value[1]
	puts "#{key} : #{value} "
end
# japana : yen
# us : dollar
# india : rupee

a = {'x'=> 1, 'y'=> 2,'z'=> 3}

#全てのキーと値が同じであればtrue
b = {'x'=>1, 'y'=>2, 'z'=>3}
a == b #=>true

#並び順が異なっていてもキーと値が全て同じならtrue
c = {'z'=> 3, 'y'=> 2, 'z'=>3}
a == c #=> true

d = {'z'=> 10, 'y'=> 2, 'z'=>3}
a == d #=>false

{}.size #=>0
{ 'x' =>1, 'y'=>2,'z'=>3 }.size #=>3

currencies = {'japan'=> 'yen','us'=> 'dollar', 'india'=> 'rupee'}
currencies.delete('japan') #=>"yen"
currencies  #=> {"us"=>"dollar","india"=>"rupee"}
currencies.delete('italy') #=>nil
#ブロックを渡すとキーが見つからない時の戻り値を作成できる
currencies.delete('itale'){|key| "Not found:#{key}" }#=> "Not found: italy"

#----- 5.3 シンボル -----

# :シンボルの名前
:apple
:japan
:ruby_is_fun
:apple.class #=>Symbol
'apple'.class #=>String
#m文字列よりもシンボルの方が高速に比較できる
'apple' == 'apple'
:apple == :apple

:apple.object_id #=>同じ
'apple'.object_id #=>毎回違う
#シンボルハエミュータブルなオブジェクト
# 文字列は破壊的な変更が可能だがシンボルは破壊的な変更はできないため「何かに名前をつけたいなどの時に有効」

string = 'apple'
string.upcase!
string #=> "APPLE"

symbol = :apple
symbol.upcase!#=>Error

# 内部的に整数なのでコンピュータは高速に値を比較できる
# 同じシンボルは同じオブジェクトであるため、メモリの使用効率が良い
# イミュータブルなので勝手に値が変えられる心配がない

'apple'.methods #=> [:include?, :unicode_normalise]
:apple.methods #=>[:<=>, :==, :===,]

#----- 5.4 続 ハッシュについて -----

currencies = {:japan => 'yen',:us=>'dollar'}
currencies[:us] #=>'dollar'
#新しくキーと値の組み合わせを追加する
currencies[:italy] = 'euro'

# =>を使わない記法
currencies = {japan: 'yen',us: 'dollar', india: 'rupee'}
#値を取り出すときは同じ
currencies[:us] #=>'dollar'
#キーも値もシンボルの場合は次のようになる
{ japan: :yen, us: :dollar,india: :rupee}
#文字列とハッシュのキーを混在させる
hash = {'abc' => 123, def: 456}
#値を取得する場合はデータ型を合わせてキーを指定する
hash['abc'] #=> 123
hash[:def] #=> 456
hash[:abc] #=> nil
hash['def'] #=>nil

#ハッシュに格納するあたに関しては異なるデータ型が混在するケースがよくある
person ={
	name: 'Alice',
	age: 20,
	freinds: ['Bob','Carol'],
	phones: {home: '123-0000',mobile: '567-8888'}
}

person[:age] #=> 20
person[:freinds] #=>"Bob","Carol"
person[:phone][:mobile] #=> "567-8000"


#メソッドのキーワード引数とハッシュ
def buy_burger(menu,drink,potato)
	#ハンバーガーを購入
	if drink
		#ドリンクを購入
	end
	if potato
		#ポテトを購入
	end
end

buy_burger('cheese',true,true)
buy_burger('fish',true,true)
#上記ではコードの可読性が悪いので、以下のようなキーワード引数を使う

def buy_burger(menu, drink: true, potato: true)
		#ハンバーガーを購入
	if drink
		#ドリンクを購入
	end
	if potato
		#ポテトを購入
	end
end

buy_burger('cheese', drink: true, potato: true)
buy_burger('fish', drink: true, potato: true)

#キーワード引数にはデフォルト値が設定されているので引数を省略することも可能
#drinkはデフォルト値のtrueを使うので指定しない
buy_burger('fish',potato: false)

#キーワード引数は呼び出し時に自由に順番を入れ替えることができる
buy_bueger('fish',potato: false, drink: true)

#デフォルト値を持たないキーワード変数は省略できない
def buy_burger(menu, drink;, potato:)
end

#キーワード引数を指定すれば、デフォルト値ありの場合と同じように使える
buy_burger('cheese',drink: true, potato: true)
#キーワード引数を省略するとエラーになる
buy_burger('fish', potato: true) #=>Error

#キーワード引数と一致するハッシュであれば、メソッドの引数として渡すことができる
params = {drink: true, potato: false}
buy_burger('fish',params)

#----- 5.5 例題：長さの単位プログラム ------

#----- 5.6 ハッシュについてもっと詳しく -----

#keys
currencies = {japan: 'yen', us: 'dollar', india: 'rupee'}
currencies.keys #=> [:japan,:us,:india]
currencies.value #=>["yen","dollar","rupee"]
currencies.has_key?(:japan) #=>true
currencies.has_key?(:italy) #=> false

# **でハッシュを展開させる
h = {us: 'dollar', india: 'rupee'}
{ japan: 'yen', **h } #=> {:japan=> "yen",:us=>"dollar",:india=>"ruppe"}

# mergeメソッドを使用しても同じ結果が得られる
h = {us: 'dollar',india: 'rupee'}
{japan:'yen'}.merge(h) #=> {:japan=> "yen",:us=>"dollar",:india=>"ruppe"}

#ハッシュを引数として受け取り、擬似キーワード引数を実現する
def buy_buger(menu,option = {})
	drink = options[:drink]
	potato = options[:potato]
end

buy_burger('cheese',drink: true,potato: true)

#任意のキーワードを受けつける**引数

def buy_burger(menu, drink: true, potato:true)
end

buy_buger('fish',drink: true,potato:false,salad: true, chicken:false)
#=> ArgumentError
#存在しないキーワードを渡すとエラーが発生するが、＊＊をつけた引数を最後に渡すとハッシュとして格納される

def buy_burger(menu, drink: true, potato:true, **others)
	#othersはハッシュとして渡される
	puts others
end
buy_buger('fish',drink: true,potato:false,salad: true, chicken:false)
#=> {:salad=> true, :chicken=>false}

#メソッドよびだすじの{}の省略
#最後の引数がハッシュであれば省略できる

#optionsは任意のハッシュを受け付ける
 def buy_bueger(menu, options = {})
 	puts options
 end

#キーワード引数の場合は呼び出し時に必ず引数名をシンボルで指定する必要がある
#ハッシュを第2匹数として渡す
buy_buger('fish',{'(drink'=> true,'potato' =>false}) #=>{'drink=>true',potato=>false}
buy_buger('fish','drink'=> true,'potato' => false)

#ハッシュリテラルの{}とブロックの{}

puts ('hello')
puts 'hello'

buy_burger {'drink' => true, 'potato' => false}, 'fish' #=>Error
#これはハッシュリテラルの{}がブロックの{}と認識されてしまったためにエラーが起きる
#konoyouhna
#場合には必ず()をつけてメソッドを呼び出す

#第1引数にハッシュの{}が来る場合は()を省略できない
buy_bueger({'drink'}=> true, 'potato'=> false}, 'fish')

#第2引数以降にハッシュが来る場合は()を省略してもエラーにならない
def buy_burger(menu, options = {})
	puts options
end

buy_burger 'fish',{'drink' => true, 'potato'=>false}
#この場合、そもそもハッシュが最後の引数なので{}を省略できる
buy_burger 'fish', 'drink'=> true, 'potato'=> false

buy_burger 'cheese', 'drink' => true, 'potato'=> false

#ハッシュから配列へ、配列からハッシュへ
currencies = { japan:'yen', us: 'dollar', india: 'rupee'}
currencies.to_a #=> [[:japan,'yen'],[:us,'dollar'],[:india,'rupee']]

array = [[:japan,'yen'],[:us,'dollar'],[:india,'rupee']]
array.to_h #=> {:japan=>"yen",:us=>"dollar",:india=>"rupee"}

#キーと値のペアの配列をHashに渡す
array = [[:japan,'yen'],[:us,'dollar'],[:india,'rupee']]
Hash[array] #=>{:japan=>"yen",:us=>"dollar",:india=>"rupee"}

#キーと値が交互に並ぶフラットな配列をsplat配列しても良い
array = [:japana, "yen", :us, "dollar", :india, "rupee"]
Hash[*arrray] #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}


#---ハッシュの初期値について ----
#ハッシュの初期値はnil
h = {}
h[:foo] #=>nil

#キーがなければ'hello'を返す
h = Hash.new('hello')
h[:foo] #=>'hello'

h = Hash.new('hello')
a = h[:foo]
b = h[:bar]
#変数aとbは同一オブジェクト
a.equal?(b) #=>true

#変数のaには快適な変更を適用すると、変数bの値も一緒に変わってしまう
a.upcase!
a #=> "HELLO"
b #=> "HELLO"

#ハッシュ自身は空のままになっている
h #=> {}

#文字列や配列など、ミュータブルなオブジェクトを初期値といて返す場合はHash.newとブロックを組み亜合わせて初期値を返すことでこのような問題を避けることができる
h = Hash.new {'hello'}
a = h[:foo] #=>"hello"
b = h[:bar] #=>"hello"

#変数aとbは異なるオブジェクト
a.equal?(b) #=>false

#変数aには快適な変更を適用しても変数βの値は変わらない
a.upcase!
a #=> "HELLO"
b #=> "hello"

h #=> {}

#初期値を返すだけでなく、ハッシュに指定されたキーと初期値を同時に設定する
h = Hash.new { |hash, key| hash[key] = 'hello' }
h[:foo] #=> "hello"
h[:bar] #=> "hello"

#ハッシュにキーと値が追加されている
h #=> {:foo=>"hello", :bar=>"hello"}

#----- 5.7 シンボルについてもっと詳しく -----
#以下は有効
:apple
:Apple
:ruby_is_fun
:okay?
:welcome!
:_secret
:@dollar
:@at_mark

#以下はエラー
# :12345
# :ruby-is-fan
# :ruby is ruby_is_fun
# :()

#シングルクオートで囲むと有効になる
:'12345'
:'ruby-is-fan'
:'ruby is ruby_is_fun'
:'()'

#ダブルクオートを使うと文字列と同じように式典会を使うことができる
name = 'Alice'
:"#{name.upcase}" #=> ALICE

#”文字列: 値"の形式で書くと、キーがシンボルになる
hash = { 'abc': 123} #=>{:abc => 123}


#%記法を使ってシンボルを作成することもできる
#！を区切る文字に使う
%s!ruby is fun! #=> :"ruby is fun"
#()を区切り文字に使う
%s(ruby is fun) #=> :"ruby is fun"

#シンボルの配列を作成する場合に、%iが使える
#その場合空白文字が要素の区切りになる
%i(apple orange melon) #=>[:apple, :orange, :melon]

name = 'Alice'
# %iでは改行文字や式展開の構文がそのままシンボルになる。
%i(hello\ngood-bye #{name.upcase}) #=>[:"hello\ngood-bye", :ALICE]
#%Iでは改行文字や式展開が有効になった上でシンボルが作られる
%I(hello\ngood-bye #{name.upcase}) #=>[:"hello\ngood-bye", :ALICE]

#-- シンボルと文字列の関係 --

string = 'apple'
symbol = :apple
string == symbol #=>false
string + symbol #=>typeerro

#to_symメソッドを使うと文字列をシンボルに変換できる
string = 'apple'
symbol = :apple
string.to_sym #=> :apple
string.to_sym == symbol #=>true
#シンボルを文字列に変換する場合はto_sメソッドが使える
string = 'apple'
symbol = :apple
symbol.to_s #=> "apple"
string == symbol.to_s #=>true
string + symbol.to_s #=>"appleapple"

#メソッドによっては文字列とシンボルを同等に扱うものがある。
#respond_to?はオブジェクトに対して文字列またはシンボルで指定した名前のメソッドを呼びだせるかどうか調べる
'apple'.respond_to?('include?') #=>true
'apple'.respond_to?(:include?) #=>true

#国名に応じて通貨を返す(該当する通貨がなければnil)
def find_currency(country)
	currencies = { japan: 'yen',us: 'dollar',india: 'rupee' }
	currencies[country]
end

#指定された国の通貨を大文字にして返す
def show_currency(country)
	currency = find_currency(country)
	#nilでないことをチェック(nilだとupcaseが呼び出せないため)
	if currency
		currency.upcase
	end
end

show_currency(:japan) #=> "YEN"
show_currency(:brazil) #=> nil

def show_currency(country)
	###条件分岐内で直接変数に代入してしまう（値が取れれば真、できなければ偽）
	if currency = find_currency(country)
		currency.upcase
	end
end

 #nil以外のオブジェクトであれば、a.upcaseと書いた場合と同じ結果になる
 a = 'foo'
 a&.upcase #=>"FOO"

 #nilであれば、nilを返す（a.upcaseと違ってエラーにならない）
 a = nil
 a&.upcase #=>nil

def show_currency(country)
	currency = find_currency(country)
	#currencyはnilの場合を考慮して、&演算子でメソッドを呼び出す
	currency&.upcase
end

#変数limit がnilまたはfalseであれば10を代入する、それ以外はlimitの値を使用する
limit || = 10

limit = nil
limit || = 10 #=>10

limit = 20
limit || = 10 #=>20
limit = limit || 10
#論理演算子の｜｜は式全体の真偽値が確定した時点で式の評価を終了し、その時の値を戻り値として返す

x || = A
#変数xがnilまたはfalseならAをXに代入

#!!を使った真偽値の型変換

def user_exists?
	user = find_user
	if user
		true
	else
		false
	end
end

def user_exists?
	!!find_user
end

#!は否定の演算子。 !Aと書いた場合はAが真であればfalseをそうでなければtrueを返す。







