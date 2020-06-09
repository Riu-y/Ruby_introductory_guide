
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
















