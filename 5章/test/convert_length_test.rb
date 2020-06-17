require 'minitest/autorun'
require './lib/convert_length'

class ConvertLengthTest < Minitest::Test
	def test_convert_length
		assert_equal 39.37, convert_length(1, from: :m,to: :in)
		assert_equal 0.38, convert_length(15, from: :in, to: :m)
		assert_equal 10670.73, convert_length(35000,from: :ft,to: :m)
	end
end

# class ConvertLengthTest < Minitest::Test
# 	def test_convert_length
# 		assert_equal 39.37,convert_length(1, 'm', 'in')
# 	end
# end

class ConvertLengthTest < Minitest::Test
	def test_convert_length_2
		assert_equal 1200, convert_length_2(12, 'm', 'cm')
		assert_equal 1, convert_length_2(1000, 'mm','m')
		assert_equal 35, convert_length_2(3500,'cm','m')
	end
end



