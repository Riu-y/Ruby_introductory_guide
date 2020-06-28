module DeepFreezable
	def deep_freeze(array_or_hash)
		case array_or_hash
		when Array
		#配列の各要素をfreeze
			array_or_hash.each do |element|
				element.freeze
			end
		when Hash
			array_or_hash.each do |key, value|
				key.freeze
				value.freeze
			end
		end
		#配列自身をfreeze（かつ、これがメソッドの戻り値となる）
		array_or_hash.freeze
	end
end
#freezeメソッドはレシーバ自身を返すため、deep_freezeメソッドの戻り値は引数で渡されたオブジェクト(array_or_hash)そのものになる

#freezeメソッドはfreezeされたレシーバ自身を返す
#[1,2,3].freeze #=>[1,2,3]
