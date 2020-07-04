require 'minitest/autorun'
require './lib/effects'

class EffectsTest < Minitest::Test
	def test_reserve
		#とりあえずモジュールが参照できることを確認する
		assert Effects
	end
end

