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

html = <<-HTML
<select name="game_console">
<option value="none"></option>
<option value="wii_u" selected>Wii U</option>
<option value="ps4">プレステ4</option>
<option value="gb">ゲームボーイ</option>
HTML

replaced = html.gsub(/<option value="(\w+)"(?: selected)?>(.*)><\/option>/, '\1,\2')
puts replaced

html = <<-HTML
<select name="game_console">
<option value="none"></option>
<option value="wii_u" selected>Wii U</option>
<option value="ps4">プレステ4</option>
<option value="gb">ゲームボーイ</option>
HTML

replaced = html.gsub(/<option value="(\w+)"(?: selected)?>(.*)<\/option>/, '\1,\2')
 puts replaced





