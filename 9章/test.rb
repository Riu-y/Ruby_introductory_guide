# puts 'Start'
# module Greeter
# 	def hello
# 		'hello'
# 	end
# end

# # greeter = Greeter.new
# #  #上の行で例外が発生するためこここからしたは実行されない
# #  puts 'End'
# begin
# 	greeter = Greeter.new
# rescue
# 	puts '例外が発生したが、このまま続行する'
# end

# puts 'END'


# # method_1にだけ例外処理を記述する
# def method_1
# 	puts 'method_1 start.'
# 	begin
# 		method_2
# 	rescue
# 		puts '例外が発生しました'
# 	end
# 	puts 'method_1 end.'
# end

# def method_2
# 	puts 'method_2 start.'
# 	method_3
# 	puts 'method_2 end.'
# end

# def method_3
# 	puts 'method_3 start.'
# 	1 / 0
# 	puts 'method_3 end.'
# end

# #処理を開始する
# method_1


# begin
# 	1 / 0
# rescue => e
# 	puts "エラークラス:#{e.class}"
# 	puts "エラーメッセージ: #{e.message}"
# 	puts "バックトレース -----"
# 	puts e.backtrace
# 	puts "----"
# end


# begin
# 	1 / 0
# rescue ZeroDivisionError
# 	puts "0で除算しました"
# end
# #=> 0で除算しました。

# begin 
# 	'abc'.foo
# rescue ZeroDivisionError, NoMethodError => e
# 	puts "0で除算したか、存在しないメソッドが呼び出されました"
# 	puts "エラー: #{e.class} #{e.message}"
# end

# retry_count = 0
# begin
# 	puts '処理を開始します。'
	#わざと例外を発生させる
# 	1 / 0
# rescue
# 	retry_count += 1
# 	if retry_count <= 3
# 		puts "retryします。（#{retry_count}回目)"
# 		retry
# 	else
# 		puts 'retryに失敗しました'
# 	end
# end


# 	begin
# 		'中島さんにジョークを含めておめでとうと伝える'
# 	rescue 誰も反応してくれないMethodError
# 		def follow_by_nakazimasan
# 	end



# def some_method(n)
# 	begin
# 		1 / 0
# 		'OK'
# 	rescue
# 		'error'
# 	ensure
# 		#ensure説にreturnを書く
# 		return 'ensure'
# 	end
# end

# p some_method(1)
# p some_method(0)

# require 'date'

# def to_date(string)
# 	begin
# 		#文字列のバースを試みる
# 		Date.parse(string)
# 	rescue ArgumentError
# 		#パースできない場合はnilを返す
# 		nil
# 	end
# end

# p to_date('2017-01-01')

# p to_date('abcdef')

# def fizz_buzz(n)
# 	begin
# 		if n % 15 == 0
# 			'Fizz Buzz'
# 		elsif n % 3 == 0
# 			'Fizz'
# 		elsif n % 5 == 0
# 			'Buzz'
# 		else
# 			n.to_s
# 		end
# 	rescue => e
# 		puts "#{e.class} #{e.message}"
# 	end
# end

# fizz_buzz

# def fizz_buzz(n)
# 	if n % 15 == 0
# 		'Fizz_Buzz'
# 	elsif n % 3 == 0
# 		'Fizz'
# 	elsif n % 5 == 0
# 		'Buzz'
# 	else
# 		n.to_s
# 	end
# rescue => e
# #発生した例外をログやメールに残す（ここはputsで代用）
# puts "[LOG]エラーが発生しました #{e.class} #{e.message}"
# #捕捉した例外を再度発生させ、プログラム自体は異常終了させる
# 	raise
# end

# fizz_buzz(nil)
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
