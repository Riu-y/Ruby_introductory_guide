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
=> {
	name: 'Alice',
	age: 20,
	gender: :female
}


text = <<TEXT
I love Ruby.
Python is a greate language.
Java and JavaScript different.
TEXT

a = text.scan(/[A-Z][A-Za-z]+/)

text = <<-TEXT
名前：柳下龍介
電話：03-1234-5678
住所：東京都渋谷区1-2-3
TEXT
text.scan /\d\d-\d\d\d\d-\d\d\d\d/
# => ["03-1234-5678"]


text = <<-TEXT
名前：柳下龍介
電話：06-9999-5678
電話：090-1234-5678
電話：0465-35-0110
電話：046-535-0110
電話：04653-5-3110
住所：東京都渋谷区1-2-3
TEXT

text.scan /\d{2,5}-\d{1,4}-\d{4}/

text = <<-TEXT
名前：柳下龍介
電話：06(9999)5678
電話：090-1234-5678
電話：0465-35-0110
電話：046(535)0110
電話：04653-5-3110
住所：東京都渋谷区1-2-3
TEXT

text.scan /\d{2,5}[-(]\d{1,4}[-)]\d{4}/


text = <<-TEXT
名前：柳下龍介
電話：03(1234)5678
？？：9999-99-9999
？？：03(1234-5678
住所：東京都渋谷区1-2-3
TEXT

numbers = text.scan(/0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}/)
# => ["03(1234)5678", "03(1234-5678"]

numbers.grep(/\(\d+\)|-\d+-/)

# => ["03(1234)5678"]
#---まとめ ----
# \d は「半角数字1文字」を表す
# {n,m} は「直前の文字が n 文字以上、m 文字以下」であることを表す
# {n} は「直前の文字がちょうど n 文字」であることを表す
# [AB] は「AまたはBが1文字」であることを表す
# [a-z] と [-az] ではハイフンの意味が異なる
# 正規表現の正確さと複雑さはトレードオフになることが多い

text = <<TEXT
クープバゲットのパンは美味しかった。
今日はクープ バゲットさんに行きました。
クープ　バゲットのパンは最高。
ジャムおじさんのパン、ジャムが入ってた。
また行きたいです。クープ・バゲット。
クープ・バケットのパン、売り切れだった（><）

TEXT

text.scan /クープ[ 　・]?バ[ゲケ]ット/
text.scan /クープ.?バ[ゲケ]ット/
#任意の1文字を表すメタ文字「.」

text.split(/\n/).grep(/クープ.?バ[ケケ]ット/)

#HTMLタグをCVSに変換する

<select name="game_console">
<option value="wii_u">Wii U</option>
<option value="ps4">プレステ4</option>
<option value="gb">ゲームボーイ</option>
</select>

<option value="([a-z0-9_]+)">(.+)<\/option>
$1,$2

# wii_u,Wii U
# ps4,プレステ4
# gb,ゲームボーイ

#一つだけnoneが含まれれてしまった場合
<select name="game_console">
<option value="none"></option> #<=追加
<option value="wii_u">Wii U</option>
<option value="ps4">プレステ4</option>
<option value="gb">ゲームボーイ</option>
</select>
# +は1文字以上、*は0文字以上
<option value="([a-z0-9_]+)">(.*)<\/option>

#1つだけselectedが含まれている場合
<select name="game_console">
<option value="none"></option> #<=追加
<option value="wii_u" selected>Wii U</option>
<option value="ps4">プレステ4</option>
<option value="gb">ゲームボーイ</option>
</select>
#A?はAまたは?の記法で2文字以上でも利用可能。使用する場合は()で囲みグループ化する( selected)?
#(?:)はキャプチャに含まない場合の記法で以下のようにすると([a-z0-9_]+)と(.*)がキャプチャと適用される
<option value="([a-z0-9_]+)"(?: selected)?>(.*)<\/option>
#0-9を\dに置き換える。\dは半角数字なので 0-9 == \d
<option value="([a-z\d_]+)"(?: selected)?>(.*)<\/option>
#[a-z\d]を\wに置き換える
#\wは[a-zA-Z0-9_]を意味するメタ文字
#[]省略して(\w+)と記述できる
<option value="(\w+)"(?: selected)?>(.*)><\/option>


replaced = html.gsub(/<option value="(\w+)"(?: selected)?>(.*)<\/option>/, '\1,\2')

puts replaced
# <select name="game_console">
# none,
# wii_u,Wii U
# ps4,プレステ4
# gb,ゲームボーイ
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

# *と＋は貪欲であることに注意する
<option value="ps4">プレステ4</option><option value="gb">ゲームボーイ</option>
replaced = html.gsub(/<option value="(\w+)"(?: selected)?>(.*)><\/option>/, '\1,\2')
#以上のように開業しないでoptionが並んでいる時、同じように(.+)を使用して検索をかけると以下のように帰ってくる
1.  ps4
2.  プレステ4</option><option value="gb">ゲームボーイ
#これは</option>から、それ以降までが検索対象に引っかかってしまっているのが原因

#解決法1
# < 以外の任意の文字>に変える
#[]の最初に^が入ると否定の意味になる
#[^AB]であれば「AでもなくBでもない任意の1文字」の意味になる
<option value ="(\w+)"(?: selected)?>([^<]*)<\/option>

#解決策2
#最短のマッチを返すように指定する
# >(.*)<の意味を厳密に示すと、「>で始まり、任意の文字が0個以上連続し(.*)、最後に見つかった<で終わる
# >(.*?)<のように?をつける。*?や+?になると最長ではなく最短のマッチとして結果を返すようになる
<option value="(\w+)"(?: selected)?<(.*?)<\/option>

# ------ まとめ -------
# ?は直前の文字が1個、または無しを表す
# .は任意の1文字を表す
# ＋は直前の文字が1個以上を表す
# ＊は直前の文字が0個以上を表す
# （）はマッチする部分をキャプチャ（捕捉）する
# キャプチャ部分は置換する時に＄1や＄2で参照できる
# \wは英単語を構成する文字（半角英数字とアンダースコア）を表す
# [^AB]はAでもなくBでもない任意の1文字を表す
# 正規表現中の特別なもじは\でエスケープする
# ()はキャプチャだけでなく、グループ化にも使われる
# (ABC)?は文字列ABCがあり、または無しを表す
# （：？）はキャプチャなしでグループ化する場合に使う
# *と+は貪欲で最長マッチを返すため。使い方を誤ると思いがけない結果が返ってくる
# *?や+?にすると最短マッチを返す





