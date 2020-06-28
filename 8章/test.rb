# module Loggable
# 	def log(text)
# 		puts "[LOG] #{text}"
# 	end
# end

# class Product
# 	#上で作ったモジュールをincludeする
# 	include Loggable

# 	def title
# 		#logメソッドはLoggaableモジュールで定義したメソッド
# 		log 'title is called.'
# 		'A great movie'
# 	end
# end

# class User
# 	include Loggable

# 	def name
# 		log 'name is called.'
# 		'Alice'
# 	end
# end

# product = Product.new
# p product.title

# user = User.new
# p user.name

# module Loggable
# 	def log(text)
# 		puts "[LOG]#{text}"
# 	end
# end

# class Product
# 	#Loggableモジュールのメソッドを特異メソッドとしてミックスインする
# 	extend Loggable

# 	def self.create_products(names)
# 		#logメソッドをクラスメソッド内で呼び出す
# 		#つまりlogメソッド自体もクラスメソッドになっている
# 		log 'create_products is called'
# 	end
# end

# #クラスメソッド経由でlogメソッドが呼び出される
# Product.create_products([])

# #Productクラスのクラスメソッドとして直接呼び出すことも可能
# Product.log('Hello')

# class Product
# 	extend Loggable

# 	# log メソッドをクラス公文の直下で呼び出す
# 	#（クラスが読み込まれるタイミングでこのlogメソッドも実行される）
# 	log 'Defined Product class.'
# # end

# module Taggable
# 	def price_tag
# 		#priceメソッドはinclude先で定義されている前提
# 		"#{price}円"
# 	end
# end

# class Product
# 	include Taggable

# 	def price
# 		1000
# 	end
# end

# product = Product.new
# p product.price_tag #=> "1000円"


#all?
# p [1,2,3].all?{ |v| v > 0 }
# #=> true
# p [1,2,3].all?{ |v| v < 1 }
# #=>false

# #上記をeachで書くと
# flg = true
# (1..3).each do |v|
# 	if v <= 0
# 		flg = false
# 		break
# 	end
# end
# p flg

p [[1,2],[3,4],[6,8]].flat_map { |v| v.map {|cv| cv * 2} }
num = []
[[1,2],[3,4]].each do |n|
	n.each do |c|
		num << c * 2
	end
end
p num
