#正規表現
#----- 6.1 イントロダクション ----

#=>を使う記法
{
	:name => 'Alice',
	:age => 20,
	:gender => :female
}

#=> を使わない記法
{
	name: 'Alice',
	age: 20,
	gender: :female
}

old_syntax = <<TEXT
{
	:name => 'Alice',
	:age=>20,
	:gender => :famale
}
TEXT

convert_hash_syntax(old_syntax)
# => {
# 	name: 'Alice',
# 	age: 20,
# 	gender: :female
# }