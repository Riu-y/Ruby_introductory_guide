def fizz_buzz(num)
	if num % 15 == 0
		'Fizz Buzz'
	elsif num % 5 == 0
		'Buss'
	elsif num % 3 == 0
		'Fizz'
	else
		num.to_s
	end
end
puts fizz_buzz(1)
puts fizz_buzz(2)
puts fizz_buzz(3)
puts fizz_buzz(4)
puts fizz_buzz(5)
puts fizz_buzz(6)
puts fizz_buzz(15)