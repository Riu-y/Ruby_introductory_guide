module SomeModule
	refine String do
		def shuffle
			chars.shuffle.join
		end
	end
	refine Integer do
		def shuffle
			chars.shuffle.join
		end
	end
	# refine Object do
	# 	def shuffle
	# 		chars.shuffle.join
	# 	end
	# end
end
