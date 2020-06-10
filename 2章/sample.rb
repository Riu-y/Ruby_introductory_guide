
puts 1 + 2

a = 'Hello, world!'
puts a

b = 'こんにちは'
puts b

'1'.to_s 

1.to_s

nil.to_s

true.to_s

false.to_s

/\d+/.to_s

#オブジェクト.メソッド(引数1,引数2,引数3)

10.to_s(16)

10.to_s 16 

1.to_s;nil.to_s; 10.to_s(16)

10.to_s \
16

=begin
ここはコメントです。
=end

＃ここはコメントです。

123

"Hello"

[1,2,3]

{'Japan'=> 'yen','us'=>'dollar','india'=>'rupee'}

/\d+-\d+/

s = 'Hello'
n = 123 * 2

x = nil

#スネークケース
special_price =200

#キャメルケース
specialPrice = 200

#あまり使われない
_special_price = 200

#2つの値を同時挿入
a,b = 1,2

#右辺の数が少ない場合はnilが入る
c,d = 10

#右辺の数が多い場合ははみ出した値が捨てられる
e,f = 100,200,300

#2つの変数に同じ値を代入する
a = b = 100

name = 'Alice'
puts "Hello,#{name}!"

puts 'He said, "Dont\'t speak."'
puts "He said, \"Dont't speak.\""

'ruby' == 'ruby'
'ruby' == 'Ruby'
'ruby' != 'perl'
'ruby' != 'ruby'

1_000_000_000

10 + 20
100 -25
12 * 5
20 /5
n = 1
-n #-1

1 / 2 #0
1.0 / 2 #0.5
1 / 2.0 #0.5

n = 1
n.to_f #1.0
n.to_f / 2 #0.5

8 % 3 #2

2 ** 3 #8

2 * 3 + 4 * 5 - 6 / 2
#23  (2 * 3)+(4 * 5)-(6 / 2)と同じ *、/は+,-よりも優先度が高い

2 * (3 + 4) * (5 - 6) / 2 #7

n = 1

# nを1増やす（n = n + 1と同じ）
n += 1  #2

# nを1減らす
n -= 1 #1

n = 2

#nを3倍にする
n *= 3  #6

# nを2で割る
n /= 2 #=>3

n **= 2 #=> 9

1 + '10.5'.to_f #=> 11.5 章終点に変換

number = 3
#文字列を数値に連結させることはできない
'Number is' + number #=>TypeError

#数値を文字列に変換する必要がある
'Number is' + number.to_s #=> "Number is 3"

#ただし式展開をつかった場合は自動的にto_sメソッドが呼ばれるので文字列に変換する必要はない
number = 3
"Number is #{number}" #=> "Number is 3"

0.1 * 3.0 == 0.3 #false
0.1 * 3.0 <= 0.3 #false

#Rationalクラスを使うと少数ではなく「10分の3」という計算結果がかえる
0.1r * 3.0r #=> (3/10)

#Rationalクラスを使用すると期待通りに値の比較ができる
0.1r * 3r == 0.3 #=>true

#変数に値が入っている場合はrationalizeメソッドを呼ぶことでRationalクラスの数値に変換んできます。
a = 0.1
b = 3.0
a.rationalize * b.rationalize # => (3/10)

(0.1r * 3.0r).to_f #=> 0.3

#------- 2.5 真偽値と条件分岐-------

data = find_data
if data != nil
	'データがあります'
else
	'データはありません'
end

data = find_data
if data
	'データがあります'
else
	'データはありません'
end

t1 = true
t2 = true
f1 = false
t1 && t2 #true
t1 && f1 #false

t1 = true
f1 = false
f2 = false
t1 || f1 #true
f1 || f2 #false

&& > ||

t1 = true
t2 = true
f1 = false
f2 = false
t1 && t2 || f1 && f2  #true
(t1 && t2) || (f1 && f2) #true

t1 = true
t2 = true
f1 = false
f2 = false
t1 && (t2 || f1) && f2 #false

t1 = true
f1 = false
!t1 #false
!f1 #true

t1 = true
f1 = false
t1 && f1 #false
!(t1 && f1) #true

n = 11
if n > 10
	puts '10より大きい'
else
	puts '10以下'
end
#=>10より大きい

country = 'italy'
if country == 'japan'
	puts 'こんにちは'
elsif	country == 'us'
	puts 'Hello'
elsif country == 'italy'
	puts 'ciao'
else
	puts '???'
end
#=> ciao

country = 'italy'
if country == 'japan'
	'こんにちは'
elsif	country == 'us'
	'Hello'
elsif country == 'italy'
	'ciao'
else
	'???'
end
#=> ciao

country = 'italy'
greeting =
if country == 'japan'
	'こんにちは'
elsif country == 'us'
	'Hello'
elsif country =='italy'
	'ciao'
else
	'???'
end

greeting # => ciao

point = 7
day = 1
if day ==1
	point *= 5
end
point #=->35

point = 7
day = 1
point *= 5 if day ==1
point #=>35

country = 'italy'
if country == 'japan' then 'こんにちは'
elsif country == 'us' then 'Hello'
elsif country == 'italy' then 'ciao'
else '???'
end

#--------2.6 メソッドの定義--------

def add(a,b)
	a + b
end
add(1,2) #=> 3

def add (a,b)
	return a + b
end
add(1,2) #=>3

def greeting(country)
	#countryがnilならメッセージを返してメソッドを抜ける
	#nilはオブジェクトがnilの場合にtrueを返すメソッド
	return 'countryを入力してください' if country.nil?

	if country == 'japan'
		'こんにちは'
	else
		'hello'
	end
end
greeting(nil) #=> "countryを入力してください"
greeting('japan') #=> 'こんにちは'

#引数がない場合は()を付けない方が一般的
def greeting
	'こんにちは'
end

def greeting()
	'こんにちは'
end

#--------- 文字列について ----------

# %q! !はシングルクォートで囲んだことになる
puts %q!He said, "Don't speak."! #=> He said, "Don't speak"

# %Q! !はダブルクォートで囲んだことと同じになる（改行文字や式展開が使える）
something = "Hello."
puts %Q!He said "#{something}"! #=> He said, "Don't Hello"

# %! !もダブルクォートで囲んだことと同じになる（改行文字や式展開が使える）
something = "Bye"
puts %!He said, "#{samething}"! #=> He said, "Don't Bye"


#ヒアドキュメント（行指向文字列リテラル）
puts "Line 1
Line 2"

puts 'Line 1,
Line 2'

a = <<TEXT
これはヒアドキュメント です。、
複数行にわたる長い文字列を作成するのに便利です
TEXT
puts a

<<HTML
<div>
	<img src="sample.jpg">
</div>
HTML

def some_method
	<<-TEXT
これはヒアドキュメントです。
<<-を使うと最後の識別子をインデントさせることができます。
	TEXT
end
puts some_method

def some_method
	<<~TEXT
	これはヒアドキュメントです。
	<<~を使うと内部文字列のインデント部分が無視されます。
	TEXT
end
puts some_method

name = 'Alice'
a = <<TEXT
ようこそ、#{name}さん!
以下のメッセージをご覧ください。
TEXT
puts a

name = 'Alice'
a = <<'TEXT'
ようこそ、#{name}さん!
以下のメッセージをご覧ください。
TEXT
puts a

name = 'Alice'
a = <<"TEXT"
ようこそ、#{name}さん!
以下のメッセージをご覧ください。
TEXT
puts a

a = 'Ruby'
a.prehand(<<TEXT)
Java
PHP
TEXT
puts a

b = <<TEXT.upcase
Hello,
Good-bye
TEXT
puts b

sprintf('%0.3f',1.2)

'%0.3f' % 1.2

sprintf('%0.3 + %0.3f, 1.2,0.48')
'%0.3f + %0.3f' % [1.2,0.48]

123.to_s

[10,20,30].join

'Hi!' * 10

string.new('Hello')

#-------- 2.9 数値について ---------

#2進数
0b111111111 #255

#8進数
0377 #255

# 16進数
0xff #255

~ #ビット反転
& #ビット積
| #ビット和
^ #排他的論理和
>> #右ビットシフト
<< #左ビットシフト

(~0b1010).to_s(2)
(0b1010 & 0b1100).to_s(2)
(0b1010 | 0b1100).to_s(2)
(0b1010 ^ 0b1100).to_s(2)

2e-3 #0.0002
10.class #integer
1.5.class #float

#有理数リテラルを使う（3rが有理数リテラル)
r = 2 / 3r
r
r.class #Rational

#文字列から有理数に変換する
r = '2/3'.to_r
r #2/3
r.class #Rational

#複素数リテラルを使う
c = 0.3 - 0.5i
c #(0.3-0.5i)
c.class #complex

#文字列から複素数に変換する
c = '0.3-0.5i'.to_c
c # (0.3-0.5i)
c.class #Conmplex

#------- 2.10 真偽値と条件分岐についてもっと詳しく --------

#Rubyは四季全体が真または偽であることが決定するまで左辺から順に指揮を評価します。指揮全体の真または偽が確定すると四季の評価を終了し、最後に評価した四季の値を返します。
1 && 2 && 3 #3
1 && nil && 3 #nil

nil || false #false
false || nil #nil
nil || false || 2 || 3 #2

#順番に検索して最初に見つかったユーザ（nilまたはfalse以外の値）を変数に格納する
user = find_user('Alice') || find_user('Bob') || find_user('Carol')

#正常なユーザであればメールを送信する（左辺が偽であればメール送信は実行されない）
user.valid? && send_email_to(user)

#優先順位が低いand,or,not
t1 = true
f1 = false
t1 and f1 #false
t1 or f1 #true
not t1 false

t1 = true
f1 = false
#!は||よりも優先順位が高い
!f1 || t1 #true

#||はnotよりも優先順位が高い
not f1 || t1 #false

#高い  !  &&  ||  not  and/or  低い

#andとorは同じ優先順位のため左から順に真偽値が評価されていきます

t1 = true
t2 = true
f1 = false

t1 || t2 && f1 #true
t1 || (t2 && f1) #上記と同じ

t1 or t2 and f1 #false
(t1 or t2) and f1 #上記と同じ、orとandは同じ優先度なので左から順に評価される

user.valid? && send_mail_to user #エラーになる
#->(user.valid? && send_mail_to) user の様に解釈されてしまった

user.valid? and send_mail_to user #実行できる
#-> (user.valid?) and(send_mail_to user)の様に解釈される

user.valid? && send_mail_to(user) #この様に書けば実行可能

def greeting(country)
	country or return 'countryを入力してください'

	if country == 'japan'
		'こんにちは'
	else
		'hello'
	end
end

greeting(nil) #countryを入力してください
greeting('japan') #こんにちは

status ='error'
if status != 'ok'
	'何か異常があります'
end

status ='error'
unless status == 'ok'
	'何か異常があります'
end

status = 'ok'
unless status == 'ok'
	'何か異常があります。'
else
	'正常です'
end

status = 'error'
message =
	unless status =='ok'
		'何か異常があります'
	else
		'正常です。'
	end
message #何か異常があります。

'何か異常があります' unless status == 'ok'
#何か異常があります。

status = 'error'
unless status == 'ok' then
	'何か異常があります'
end

country = 'italy'
when 'japan'
	'こんにちは'
when 'us'
	'Hello'
when 'italy'
	'ciao'
else
	'???'
end

#case文ではwhen節に複数の値を指定し、どれかに一致すれば処理を実行するというう条件分岐を買うことができる

country = 'アメリカ'
case country
when 'japan','日本'
	'こんにちは'
when 'us','アメリカ'
	'hello'
when 'italy','イタリア'
	'ciao'
else
	'???'
end
#hello


country = 'italy'
message =
case country
when 'japan','日本'
	'こんにちは'
when 'us','アメリカ'
	'hello'
when 'italy','イタリア'
	'ciao'
else
	'???'
end
#ciao

country = 'italy'

case country
	when 'japan' then 'こんにちは'
	when 'us' then 'hello'
	when 'italy' then 'ciao'
	else '???'
	end
	#ciao

	#条件演算子（三項演算子）

n = 11
if n > 10
	'10よりおおきい'
else
	'10以下'
end

n = 11
n > 10 ? '10より大きい' : '10以下'

n = 11
message = n >10 ? '10より大きい' : '10以下'
message #10より大きい

#------- メソッド定義についてもっっと詳しく ---------

def greeting(country)
	if country =='japan'
		'こんにちは'
	else
		'hello'
	end
end
greeting #NG deficiency
greeting('us') #OK
greeting #NG excess


def greeting(country = 'japan')]
	if country == 'japan'
		'こんにちは'
	else
		'hello'
	end
end
greeting #こんにちは
greeting('us') #hello


def default_args(a,b,c = 0, d = 0)
	"a=#{a},b=#{b},c=#{c},d=#{d}"
end
default_args(1,2) #"a=1,b=2,c=0,d=0"
default_args(1,2) #"a=1,b=2,c=3,d=0"
default_args(1,2,59,7) #"a=1,b=2,c=59,d=7"

#システム日時や他のメソッドのもどり値をデフォルト値に指定する
def foo(time = Time.now,message = bar)
	puts "time: #{time}, message:#{message}"

def bar
	'Bar'
end
foo #time: 2020-06-10 12:15:35, message: BAR


''.empty? #true
'abc'.empty? #false

'watch'.include?('at') #true
'watch'.include?('in') #false

#奇数ならtrue,偶数ならfalse
1.odd? #true
2.odd? #false

#偶数ならtrue,奇数ならfalse
1.even? #false
2.even? #true

nil.nil? #true
'abc'.nil? #false
1.nil? #false

def multiple_of_three?(n)
	n % 3 == 0
end

multiple_of_three?(4) #false
maltiple_of_three?(5) #false
maltiple_of_three?(6) #true

a = 'ruby'

a.upcase #"Ruby"
a # 'ruby'

a.upcase! #"Ruby"
a #"Ruby"

def reverse_upcase!(s)
	 s.reverse!.upcase!
end

s ='ruby'
reverse_upcase!(s)
s #"YBUR"

#------- その他の基礎知識 ---------

#エイリアスメソッド
'hello'.length #5
'hello'.size #5

#擬似変数
nil
true
false
self
__file__
__Line__
__Encording__

a = 'hello'
b = 'hello'
a.object_id #7019111
b.object_id #7018223

c = b
c.object_id  #7018223 #Bと同じ

def m(d)
	d.object_id
end
m(c)  #7018223

#equal?メソッドを使って同じオブジェクトを確認
a.equal?(b) #false
b.equal?(c) #true

#自分で書いたプログラムを読み込む
require './sample.rb'
require './sample'

#不具合があったので、sample.rbを修正する

#しかし、もう一度requireしてもすでに読み込み済みのなので修正が反映されない
require './sample.rb' #false

#loadwp使用すると無条件に再読み込みできる
load './sample.rb'

#require_relativeを使って自分のファイルを起点にする

--foo/
|  |---hello.rb
|
|----bar/
			|----bye.rb

#>app/foo/hello.rb
require_relative '../bar/bye'

puts 123 
=> nil
#putsメソッドは改行を加えて内容やメソッドの戻り値をターミナルに出力する。また戻り値はnil

print 123
123 =>nil
#printメソッドは改行を加えない

#pメソッドはputsメソッドと同じ様に改行を加えて出力する。ただし文字列を出力すると、その文字列がダブルクォートで囲まれている点がputsメッ外異なる。
#pメソッドは引数で渡されたオブジェクトそのものがメソッドの戻り値になる
p 123
123
=> 123

p 'abc'
"abc"
=> "abc"
s = "abc/ndef"
=> "abc/ndef"

puts s
abc
def
=>nil

print s
abc
def =>nil
p s
"abc\ndef"
=> "abc\def"

#配列の場合

a = [1,2,3]
=>[1,2,3]

puts a
1
2
3
=> nil

print a
[1,2,3]=> nil

p a
[1,2,3]
=>[1,2,3]

#文字列をinspectするとダブルクオート付きの文字列が返る
'abc'.inspect => "\"abc\""


















