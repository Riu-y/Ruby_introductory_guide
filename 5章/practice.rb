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
