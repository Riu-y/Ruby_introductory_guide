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

#------ 4.6 ------

to_hex(0,0,0) 












