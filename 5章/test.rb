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

p show_currency(:japan) #=> "YEN"
p show_currency(:brazil) #=> nil


 #nil以外のオブジェクトであれば、a.upcaseと書いた場合と同じ結果になる
 a = 'foo'
p a&.upcase #=>"FOO"
 #nilであれば、nilを返す（a.upcaseと違ってエラーにならない）
 b = nil
p b&.upcase #=>nil
