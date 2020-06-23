# text = <<TEXT
# I love Ruby.
# Python is a greate language.
# Java and JavaScript different.
# TEXT

# a = text.scan(/[A-Z][A-Za-z]+/)
# p a


# text = <<-TEXT
# 名前：柳下龍介
# 電話：03-1234-5678
# 住所：東京都渋谷区1-2-3
# TEXT
# p text.scan /\d\d-\d\d\d\d-\d\d\d\d/
# # => ["03-1234-5678"]


# text = <<-TEXT
# 名前：柳下龍介
# 電話：06-9999-5678
# 電話：090-1234-5678
# 電話：0465-35-0110
# 電話：046-535-0110
# 電話：04653-5-3110
# 住所：東京都渋谷区1-2-3
# TEXT

# p text.scan /\d{2,5}-\d{1,4}-\d{4}/

# text = <<-TEXT
# 名前：柳下龍介
# 電話：06(9999)5678
# 電話：090-1234-5678
# 電話：0465-35-0110
# 電話：046(535)0110
# 電話：04653-5-3110
# 住所：東京都渋谷区1-2-3
# TEXT

# p text.scan /\d{2,5}[-(]\d{1,4}[-)]\d{4}/


# text = <<-TEXT
# 名前：柳下龍介
# 電話：03(1234)5678
# ？？：9999-99-9999
# ？？：03(1234-5678
# 住所：東京都渋谷区1-2-3
# TEXT

# numbers = text.scan(/0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}/)
# # => ["03(1234)5678", "03(1234-5678"]
# p numbers

# numbers.grep(/\(\d+\)|-\d+-/)
# # => ["03(1234)5678"]
# p numbers

# text = <<TEXT
# クープバゲットのパンは美味しかった。
# 今日はクープ バゲットさんに行きました。
# クープ　バゲットのパンは最高。
# ジャムおじさんのパン、ジャムが入ってた。
# また行きたいです。クープ・バゲット。
# クープ・バケットのパン、売り切れだった（><）

# TEXT

# p text.scan /クープ[ 　・]?バ[ゲケ]ット/
# p text.scan /クープ.?バ[ゲケ]ット/

# p text.split(/\n/).grep(/クープ.?バ[ゲケ]ット/)

# <select name="game_console">
# <option value="wii_u">Wii U</option>
# <option value="ps4">プレステ4</option>
# <option value="gb">ゲームボーイ</option>
# </select>

# html = <<-HTML
# <select name="game_console">
# <option value="none"></option>
# <option value="wii_u" selected>Wii U</option>
# <option value="ps4">プレステ4</option>
# <option value="gb">ゲームボーイ</option>
# HTML

# replaced = html.gsub(/<option value="(\w+)"(?: selected)?>(.*)><\/option>/, '\1,\2')
# puts replaced

# html = <<-HTML
# <select name="game_console">
# <option value="none"></option>
# <option value="wii_u" selected>Wii U</option>
# <option value="ps4">プレステ4</option>
# <option value="gb">ゲームボーイ</option>
# HTML

# replaced = html.gsub(/<option value="(\w+)"(?: selected)?>(.*)<\/option>/, '\1,\2')
#  puts replaced

# text = <<-TEXT
# type=zip; filename=users.zip; size=1024;
# type=xml; filename=posts.xml; size=2048;
# TEXT

# p text.scan(/(?<=filename=)[^;]+/)

# #肯定の後読みを行わない場合
# text = <<-TEXT
# type=zip; filename=users.zip; size=1024;
# type=xml; filename=posts.xml; size=2048;
# TEXT

# p text.scan(/filename=[^;]+/).map {|s| s.split('=').last}

# text = <<-TEXT
# John:guitar, George:guitar, Paul:bass, Ringo:drum
# Freddie:vocal, Brian:guitar, John:bass, Roger:drum
# TEXT

# p text.scan(/\w+(?=:bass)/)

# text = <<-TEXT
# 東京都
# 千葉県
# 神奈川県
# 埼玉都
# TEXT

# p text.scan(/(?<!東京)都/)

# text = <<-TEXT
# <a href="http://google.com">http://google.com</a>
# <a href="http://yahoo.co.jp">ヤフー</a>
# <a href="http://facebook.com">http://facebook.com</a>
# TEXT

# p text.scan(/<a href="(.+?)">\1<\/a>/)

# text = <<-TEXT
# You say yes. - @jnchito 8s
# I say no. - @BarackObama 12m
# You say stop. - @dhh 7h
# I say go go go. - @ladygaga Feb 20
# Hello, goodbye. - @BillGates 11 Apr 2015
# TEXT

# p text.scan(/^(.*) - (@\w+) (\d+[smh]|(?:\d+ )?[A-Z][a-z]{2} \d+)/)

# text = '私の誕生日は1977年7月17日です。'
# m = /(\d+)年(\d+)月(\d+)日/.match(text)
# p m[1]
# p m[2]
# p m[3]

# text = '私の誕生日は1977年7月17日です。'
# m = /(\d+)年(\d+)月(\d+)日/.match(text)
# p m[0]
# p m[1]
# p m[2,2]
# p m[-1]
# p m[1..3]

# text ='私の誕生日は1977年7月17日です。'
# m = /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/.match(text)

# p m[:year]
# p m[:month]
# p m[:day]
# p m[2]

# text = '私の誕生日は1977年7月17日です。'
# #キャプチャの名前がそのままローカル変数に割り当てられる
# if /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/=~ text
# 	puts "#{year}/#{month}/#{day}"
# end

# p '1997年7月17日 2016年12月31日'.scan(/(\d+)年(\d+)月(\d+)日/)

# p'1997年7月17日 2016年12月31日'.scan(/(?:\d+)年(?:\d+)月(?:\d+)日/)

# p '1997年7月17日 2016年12月31日'.scan(/\d+年\d+月\d+日/)

# text = '123,456-789'
# p text.gsub(',',':') #=> "123:456-789"
# p text.gsub(/,|-/, ':') #=>123:456:789

# text2 = '私の誕生日は1977年7月17日です。'
# p text2.gsub(/(\d+)年(\d+)月(\d+)日/,'\1-\2-\3')

# text = "私の誕生日は1977年7月17日です。"
# p text.gsub(
# 	/(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/,
# 	'\k<year>-\k<month>-\k<day>'
# 	)


# text = '123,456-789'
# hash {','=>':','-' => '/' }
# p text.gsub(/,|-/, hash)


# text = '123,456-789'
# p text.gsub(/,|-/) {|matched| matched == ',' ? ':' : '/' }

# text = '123,456-789'
# text.gsub!(/,|-/,':')
# p text #=> "123:456:789"

# text = '03-1234-5678'

# case text
# when /^\d{3}-\d{4}$/
# 	puts '郵便番号です'
# when /^\d{4}\/\d{1,2}\/\d{1,2}$/
# 	puts '日付です'
# when /^\d+-\d+-\d+$/
# 	puts '電話番号です'
# end

# p 'HELLO' =~ /hello/i #=0
# p "Hello\nBye" =~ /Hello.Bye/m #=> 0

text = '私の誕生日は1977年7月17日です。'
text =~ /(\d+)年(\d+)月(\d+)日/

# p $~

# p $&
# p $1
# p $2
# p $3
# p $+

p Regexp.last_match
p Regexp.last_match(1)
p Regexp.last_match(2)
p Regexp.last_match(3)
p Regexp.last_match(-1)



