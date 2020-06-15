to_hex(0,0,0) #'#00000'
to_hex(255, 255, 255) #'#ffffff"
to_hex(4, 60, 120)# ' #s043c78'
to_ints('#000000') #[0,0,0]
to_ints('#ffffff') #[255,255,255]
to_ints('#043c78') #[4, 60, 120]


#------ 4.2 配列 -------

a = [1,2,3]

a = [
	1,
	2,
	3
]

a = ['apple', 'orange', 'melon']
a = [1,'apple',2,'orange',3,'melom']

a =[[10,20,30][40,50,60]]

a = [1,2,3]

a[0] #1

a[1] #2

a[100] #nil

a.size #3
a.length #3

a = [1,2,3]
a[1] = 20 
# [1,20,3]

a = [1,2,3]
a[4] = 50
#[1,2,3,nil,50]

a = []
a << 1
a << 2
a << 3
# a => [1,2,3]

a =[1,2,3]
a.delete_at(1)
a # [1,3]

a.delete_at(100) #nil

a,b = 1,2
a #1
b #2

a,b = [1,2]

c,d = [10]
#c 100
#d nil

e, f = [100, 200, 300]
e # 100
f # 200

#divmodは商と余りを配列で返す
14.divmod(3) #=>[4,2]

#戻り値を配列のまま受け取る
quo_rem = 14.divmod(3) #=>[4,2]
"商=#{quo_rem[0]},余り=#{quo_rem[1]}" #商=4, 余り=2

#多重代入で別々の変数として受け取る
quotient, remainder = 14.divmod(3)
"商=#{quotient},余り=#{remainder}" #商=4, 余り=2

#------ 4.3 ブロック ------

numbers = [1,2,3,4]
sum = 0
numbers.each do |n|
	sum += n
end
sum # 10

a = [1,2,3,1,2,3]
#配列から値が奇数の要素を削除する
a.delete_if do |n|
	n.odd?
end
a #=>[2,2]

numbers = [1,2,3,4]
sum = 0
numbers.each do |n|
	sum += n
end

numbers.each do
	sum += 1
end

numbers = [1,2,3,4]
sum = 0

numbers.each do |n|
	sum_value = n.even? ? n * 10 : n
	#条件演算子 => 条件式 ? 真の時の値 : 偽の時の値
	sum += sum_value
end
#ブロックの外に出るとsam_value は参照できない
sum_value
#=> NameError:

numbers = [1,2,3,4]
sum = 0
numbers.each do |n|
	sum_value = n.even? ? n * 10 : n
	sum += sum_value
end

#シャドーイング ブロック引数の名前wpブロック外にある変数の名前と同じにすると。ブロック内ではブロック引数の値が優先して参照される
numbers = [1,2,3,4]
sum = 0
sum_value = 100
numbers.each do |sum_value|
	sum += sum_value
end
sum # => 10

numbers = [1,2,3,4]
sum = 0
#ブロックをあえて改行せずに書く
numbers.each do |n| sum += n end
sum


numbers = [1,2,3,4]
sum = 0
#ブロックをあえて改行せずに書く
numbers.each {|n| sum += n }
sum # => 10

#----- 4.4 ブロックを使う配列のメソッド ------

numbers = [1,2,3,4,5]
new_numbers = []
numbers.each { |n| new_numbers << n * 10 }
new_numbers #=> [10,20,30,40,50]


numbers = [1,2,3,4,5]
new_numbers = numbers.map { |n| n * 10 }
new_numbers #=> [10,20,30,40,50]


numbers = [1,2,3,4,5,6]
#ブロックの戻り値が真になった要素だけが集められる
even_numbers = number.select { |n| n.even? }
even_numbers #=>[2,4,6]


numbers = [1,2,3,4,5,6]
#3の倍数を除外する
non_multiples_of_three = numbers.reject{ |n| n % 3 == 0 }
non_multiples_of_three # [1,2,4,5]


numbers = [1,2,3,4,5,6]
#ブロックの戻り値が最初に真になった要素を返す
even_number = number.find { |n| n.even? }
even_number #=>2


numbers = [1,2,3,4]
sum = 0
numbers.each {|n| sum += n}
sum #=> 10

numbers = [1,2,3,4]
sum = numbers.inject(0){ |result, n| result + n }
sum #=>10


['ruby','java','perl'].map { |s| s.upcase } #=> ["RUBY",'JAVA',"PERL"]
#以下の様に書き換えられる
['ruby','java','perl'].map(&:upcase ) #=> ["RUBY",'JAVA',"PERL"]

[1,2,3,4,5,6].select { |n| n.odd? } #=>[1.3,5]
[1,2,3,4,5,6].select (&:odd?) #=>[1.3,5]
# &:メソッドの条件
# 1.ブロック引数が1個である
# 2.ブロックの中で呼び出すメソッドには引数がない
# 3.ブロックの中ではブロック引数に対してメソッドを1回呼び出す以外の処理がない

#------ 4.5 範囲 ------

(1..5).class
(1...5).class

range = 1..5
range.include?(0) #true
range.include?(1) #true
range.include?(4.9) #true
range.include?(5) #true
range.include?(6) #false

range = 1...5
range.include?(0) #true
range.include?(1) #true
range.include?(4.9) #true
range.include?(5) #false
range.include?(6) #false

1..5.include?(1) #Error
(1..5).include?(1) #true

a = [1,2,3,4,5]
a[1..3] #=>[2,3,4]2番目から4番目までの要素を取得する

a = 'abcdef'
#2文字目から4文字目までを抜き出す
a[1..3] #=>"bcd"

def liquid?(temperature)
	0 <= temperature && temperature < 100
end
liquid?(-1) #false
liquid?(0) #true
liquid?(99) #true
liquid?(100) #false


def liquid?(temperature)
	(0...100).include?(temperature)
end
liquid?(-1) #false
liquid?(0) #true
liquid?(99) #true
liquid?(100) #false

def charge(age)
	case age
	when 0..5
		0
	when 6..12
		300
	when 13.. 18
		600
	else
		1000
	end
end

charge(3) #=>0
charge(12) #=>300
charge(16) #=>600
charge(25) #=>1000

(1..5).to_a #=>[1,2,3,4,5]
(1...5).to_a #=>[1,2,3,4]

('a'..'e').to_a #=> ["a","b","c","d","e"]
('a'...'e').to_a #=> ["a","b","c","d"]

('bad'..'bag').to_a #=>["bad","bae","baf","bag"]
('bad'...'bag').to_a #=>["bad","bae","baf"]

[*1..5] #=>[1,2,3,4,5]
[*1...5] #=>[1,2,3,4]

numbers = (1..4).to_a
sum = 0
numbers.each { |n| sum += n }
sum #=>10

sum = 0
#範囲オブジェクトに対して直接eachメソッドを呼び出す
(1..4).each { |n| sum += n }
sum #=>10

number = []
#1から10まで2つ飛ばしで繰り返し処理を行う
(1..10).step(2) { |n| numbers << n }
numbers #=> [1,3,5,7,9]

(1..15).step(3){ |n| numbers << n }
numbers #=>[1,4,7,10,13]

#------ 4.6 RGBテスト------

to_hex(0,0,0)

#------ 4.7  配列についてもっと詳しく------

a = [1,2,3,4,5]
a[1,3 ] #=> [2,3,4]

a = [1,2,3,4,5]
a.value_at(0,2,4) #=>[1,3,5]

a = [1,2,3]
#最後の要素を取得する
a[a.size - 1] #=> 3

a = [1,2,3]
a[-1] #=> -3
a[-2,2]

a[-2,2] #=> [2,3]

a =[1,2,3]
a.last #=> 3
a.last(2) #=>[2,3]
a.first #=>1
a.first(2) #=> [1,2]

a = [1,2,3]
a[-3] = -10 #=>[-10,2,3]

#指定可能な負の値よりも小さくなるとエラーが発生する
a[-4] = 0 #=>indexEroor

a = [1,2,3,4,5]
#2つ目から3余所分を100で置き換える
a[1,3] = 100
a #=>[1,100,5]

a = []
a.push(1) #=>[1]
a.push(2,3) #=>[1.2,3]

a = [1,2,3,1,2,3]
#洗いが2である要素を削除する
a.delete(2) #=>[1,3,1,3]

#存在しない要素を削除しようとするとnilが帰ってくる
a.delete(5) #=>nil
a

a = [1]
b = [2,3]

a.contact(b) #=>[1,2,3]
#aは破壊される（破壊的）
a #=> [1,2,3]
# bは破壊されない
b #=> [2,3]

#+を使うと素の配列を変更せずに、新しい配列を作成する
a = [1]
b = [2,3]
a + b #=> [1,2,3]

#aもbも変更されない（破壊的）
a #=>[1]
b #=>[2,3]

#配列を連結させる時は基本的には＋が良い

a = [1,2,3]
b = [3,4,5]
a | b #=>[1,2,3,4,5]
#|,-,&を使って和集合、差酒豪、積集合を求めつことができます
#いずれも素の配列は破壊しない


#｜は和集合を求める演算子です。2里の配列の要素を全てて集めて重複しないようにして返します。
a = [1,2,3]
b = [3,4,5]
a - b #=>[1,2]

#-は差集合を求める演算子。左の配列から右の配列に含まれる要素を取り除く
a = [1,2,3]
b = [3,4,5]
a & b #=>3

#&は積集合を求める演算子、2つの配列に共通する要素を返す。
a = [1,2,3]
b = [3,4,5]
a & b #=>[3]

#Rubyには効率的に集合を扱えるSetクラスもあり本格的な集合演算をする場合は配列よりもD Setクラスを使う方が良い。

require 'set'

a = Set.new([1,2,3])
b = Set.new([3,4,5])
a | b #=>  Set: {1,2,3,4,5 }
a - b #=>  Ser: {1,2}
a & b #=>  Set: {3}

#多重代入で残りの前要素を配列として受けとる
e,f = 100,200,300
e #=> 100
f #=> 200

e, *f  = 100,200,300
e #=> 100
f #=> [200,300]

#1つの配列を複数の引数として展開する
a = []
a.push(1) #=>[1]
a.push(2,3) #=>[1,2,3]

a = []
b = [2,3]
a.push(1) #=> [1]
a.push(b) #=> [1,[2,3]]

a = []
b = [2,3]
a.push(1)
a.push(*b) #=>[1,2,3]

#メソッドの可変調変数

def greeting(*name)
	"#{names.join('と')}、こんにちは！"
end

greeting('田中さん') #=> 田中さん、こんにちは！
greeting('田中さん','鈴木さん') #=>田中さんと鈴木さん、こんにちは！
greeting('田中さん','鈴木さん','佐藤さん')#田中さんと鈴木さんと、佐藤さん、こんにちは！

# *で配列同士を非破壊的に連結する
a = [1,2,3]

#[]の中にそのまま配列を置くと配列の配列のなる
[a] #{=> [[1,2,3]]

# *付きで配列を置くと、展開されて別々の要素になる
[*a] #=>[1,2,3]

a = [1,2,3]
[-1,0.*a,4,5]
a =[1,2,3]
[-1,0] + a + [4, 5]

a = [1, 2, 5]
[-1,0]+ a + [4, 5]
#=> [-1, 0, 1, 2, 3, 4, 5]

[1, 2, 3] == [1, 2, 3] #=>true

['apple', 'melon', 'orange']

%w!apple melon orange!

%W(apple melon orange)

%w(
	apple
	melon
	orange
	)

%w(big\ apple small\ melon orange)

prefix = 'This is'
%W(#{prefix}\ an\ apple small\ melon","orange")

'Ruby'.chars #=> ["R", "u", "b ","y"]
'Ruby,Java,Perl,PHP'.split(',') #=> ['Ruby',"Java","Perl","PHP"]

a = Array.new

a = Array.new(5)

#要素が5つの配列を作成する
a = Array.new(5)
a #=>[nil,nil,nil,nil,nil]

#要素が5つで0
a = Array.new(5,0)

a = Array.new(10){|n| n % 3 +1 }
a #=> [1,2,3,1,2,3,1,2,3,1]

a = Array.new(5, 'defalt')

str = a[0]
str #=> "defalt"

str.update!
str #=> "DEFALT"

a #=> ["DEAULT","DEFAULT","DEFAULT"]

a = Array.new(5) {'default'}

str = a[0]
str #=> default

str.upcase!
str

a #=> ["DEFALT","default"...]

a = Array.new(5, 0)
a #=>[0,0,0,0,0]

n = a [0]
n #=> 0

#数値だと破壊的な変更はできない
#n.negative!

a = 'abcde'
a[2] "c"
a[1..3] #bcd
a[-1] #e

a[0] = 'x'
a #=>"xbcde"

a[1,3] = 'Y'
a

a << 'PQR'
a #=> "XYePQR"

#------ 4.8 ブロックについtrもっと詳しく ------

fruits = ['apple', 'orange','melon']
 #ブロック引数のiには0,1,2...と要素の添え字が入る
	fruits.each_with_index { |fruit, i| puts "#{i}: #{fruit}" }
	# 0: apple
	# 1: orange
	# 2: melon


fruits = ['apple', 'orange','melon']
#mapとして処理しつつ、添え字も受け取る
fruits.map.with_index {|fruit, i| "#{i}: #{fruit}"}
#=> ["0: apple,1: orange,2:,melon"]

fruits =['apple','orange','melon']
#名前にaを含み、なおかつ添字が奇数である要素を削除する
fruits.delete_if.with_index { |fruit, i| fruit.include?('a') && i.odd?}

fruits = ['apple','orange','melon']


fruits = ['apple','orange','melon']

#eachで繰り返しつつ、1から始まる添え字を取得する
fruits.each.with_index(1) {|fruit, i|puts "#{i}: #{fruit}"}


#mapで処理しつつ、10から始まる添え字を取得する
fruits.map.with_index(10) { |fruit,i| " #{i}: #{fruit} "}

dimentions = [
	[10,20],
	[30,40],
	[50,60],
]

areas = []

dimensions.each do | dimention |
	length = dimension[0]
	width = dimention[1]
	areas << length * width
end
areas #=> [200,1200,3000]

dimentions = [
	[10,20],
	[30,40],
	[50,60],
]

areas = []
dimentions.each do |length, width|
	areas << length * width
end
areas #=>[200, 1200, 3000]

demensions = [
[10,20],
[30,40],
[50,60],
]

areas = []
dimensions.each do |length, width|
	areas << length * width
end
areas

numbers = [1,2,3,4]
sum = 0

#ブロックの外にあるsumとは別物の変数sumを用意
numbers.each so |n; sum|
 #別物のsumを10で初期化し、ブロック引き数の値を加算する
sum =10
sum += n
#加算した値をターミナルに表示する
p sum 
end

File .open("./sample.txt","w")do |file|
	file.puts("1行目のテキストです。")
	file.puts("2行目のテキストです。")
	file.puts("3行目のテキストです。")
end

a = [1,2,3]

# ブロックをわた際時は指定した値が見つからないとNilが返る
a.delete(100)

a.delete(100) do
	'NG'
end
 #do ..end よりも{}の方が結合度が強い

a.delete 100 { 'NG'} #=> Error

a.delete(100) { 'NG' } #=> "NG"

names = ['田中', '鈴木', '佐藤']
san_names = names.map { |name| "#{name}さん"} #=>["田中さん","鈴木さん","佐藤さん"]
san_names.join('と')
 #=>"田中さんと鈴木さんと佐藤さん"

names = ['田中','鈴木', '佐藤']
names.map { |name| "#{name}さん" }.join('と')
#=>"田中さんと鈴木さんと佐藤さん"

names = ['田中','鈴木', '佐藤']
names.map do |name|
	"#{name}さん"
end.join('と')
#=>#=>"田中さんと鈴木さんと佐藤さん"

#------ 4.9 様々な繰り返し処理------

sum = 0
#処理を5回繰り返す。nには0,1,2,3,4が入る
5.times {|n| sum += n }
sum #=> 10

sum = 0
#不要な場合はブロック省略可能
5.times {sum += 1}
sum

a = []
10.upto(14){|n| a << n }
a #=> [10,11,12,13,14]

a = []
14.downto(10){|n| a << n }
a #=> [14,13,12,11,10]

a = []
10.upto(15){|n| a << n }

a = []
1.step(10,2){ |n| a << n }
a #=> [1,3,5,7,9]

a = []
10.step(1, -2) { |n| a << n }
a #=> [10,8,6,4,2]


























[a] #=>[[1,2,3]]











