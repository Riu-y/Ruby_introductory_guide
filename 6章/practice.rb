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

# ----正規表現 part2 -----

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

# ----正規表現 part3 -----

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


#空行に含まれる無駄なスペースやタブを削除する
text = <<-TEXT
def hello(name)
  puts "Hello, \#{name}!"
end

hello('Alice')
     
hello('Bob')
	
hello('Carol')
TEXT

puts text.gsub(/^[ \t]+$/, '')
#^は行頭、$は行末、\tはタブ文字

# def hello(name)
#   puts "Hello, #{name}!"
# end
# 
# hello('Alice')
# 
# hello('Bob')
# 
# hello('Carol')


#ログから特定の行を削除する
Feb 14 07:33:02 app/web.1:  Completed 302 Found ...
Feb 14 07:36:46 heroku/api:  Starting process ...
Feb 14 07:36:50 heroku/scheduler.7625:  Starting ...
Feb 14 07:36:50 heroku/scheduler.7625:  State ...
Feb 14 07:36:54 heroku/router:  at=info method=...
Feb 14 07:36:54 app/web.1:  Started HEAD "/" ...
Feb 14 07:36:54 app/web.1:  Completed 200 ...

#(|)でorの意味を持つ
^.+heroku\/(api|scheduler).+$

#--- ^は場所によって意味が変わる---

# [^AB]はAでもなくBでもない1文字
# ABCDEF
# !@#$%^&*
#=> CDEF!@#$%^&*

#[AB^]はAまたはBまたは^のいずれか1文字
# ABCDEF
# !@#$%^&*
#=> AB^

# ^.は行頭に来る1文字
# ABCDEF
# !@#$%^&*
#=> A ！

# /^は^という文字を検索したい時に使う
# ABCDEF
# !@#$%^&*
#=> ^

#---まとめ ---
# ^は行頭を表す
# $は行末を表す
# \tはタブ文字を表す
# \n は改行文字を表す
# \sは空白文字（スペース、タブ、改行文字）を表す
# ABC|DEFは、文字列のor条件を表す
# ^は状況や使い方によって意味が異なる


# ----正規表現 part4 -----

#以下のような文章から「ear」のみを取り出したい場合
#\b \bを使用して取り出すことができる

# sounds that are pleasing to the ear.
# ear is the organ of the sense of hearing.
# I can't bear it.
# Why on earth would anyone feel sorry for you?
\bear\b #=> ear


#以下の文のようにI18.tのメソッドを使用している時に,I18.tのメソッドを抜き出したい時、tで検索すると文字としてのtも検索に引っかかってしまう。
#メソッドの呼び出しにはI18.t('show')などと書かれているので"t"の前後にはピリオドやかっこ、スペースが含まれるので英気表現上で境界線とみなされる。
#よって\bt\bと記述するとtメソッドを検索できる
<td>
<%= link_to I18n.t('.show'), user %>
<%= link_to t('.edit'), edit_user_path(user) %>
</td>
\b.t\b #=> t t

#-- 肯定の後読み --
type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
#上記のような文字列内のファイル名を検索したい時に
filename=([^:]+)
#上記で検索ができるがさらに効率の良い方法が以下
(?<=filename=)[^;]+
#(?<=ABC)というように書くとABCの直後の位置にマッチする。これを肯定の後読みという

text = <<-TEXT
type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
TEXT
text.scan(/(?<=filename=)[^;]+/)
# => ["users.zip", "posts.xml"]


text = <<-TEXT
type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
TEXT
text.scan(/filename=[^;]+/).map {|s| s.split('=').last}
# => ["users.zip", "posts.xml"]

# ---肯定の先読み ---
John:guitar, George:guitar, Paul:bass, Ringo:drum
Freddie:vocal, Brian:guitar, John:bass, Roger:drum
上記のような文字列の中でBass担当の名前を検索したい時に
\w+:bass #=> Paul:bass John:bass
#上記のようにすれば:bass付きで取得できるが名前だけを検索したい時
#(?=)を使って(?:=:bass)とすれば目的のように検索できる。これを肯定の先読みという
\w+(?=:bass)


text = TEXT <<-TEXT
John:guitar, George:guitar, Paul:bass, Ringo:drum
Freddie:vocal, Brian:guitar, John:bass, Roger:drum
TEXT

text.scan(/\w+(?=:bass)/) #=>["Paul", "John"]


#--- 否定の後読み ---

#以下のテキストから間違っている都道府県を見つける
# 東京都
# 千葉県
# 神奈川県
# 埼玉都

text = <<-TEXT
東京都
千葉県
神奈川県
埼玉都
TEXT

text.scan(/(?<!東京)都/)


# (?<!東京)都 #=>都
#上記の記法で誤っている都の誤った表記を探すことができる
#(?<!ABC)でABC以外の直後の位置にマッチしてくれる。今回の場合、東京以外の直後にマッチさせてその後から都を検索できるようにした

#---- 否定の先読み -----
#以下のテキストから食べ物のサザエを検索する
# サザエ(?!さん)
# つぼ焼きにしたサザエはおいしい
# 日曜日にやってるサザエさんは面白い

text = <<-TEXT
つぼ焼きにしたサザエはおいしい
日曜日にやってるサザエさんは面白い
TEXT
text.scan(/サザエ(?!さん)/)

#(?!ABC)と書くとABCという文字列ではない直前の位置にマッチするこれを否定の先読みという
#例題の場合、「さん」と続く文字列ではない直前の位置してサザエを検索している

#---後方参照---
#-- UPLがページにそのまま表示されているリンクを見つける--

# <a href="http://google.com">http://google.com</a>
# <a href="http://yahoo.co.jp">ヤフー</a>
# <a href="http://facebook.com">http://facebook.com</a>

text = <<-TEXT
<a href="http://google.com">http://google.com</a>
<a href="http://yahoo.co.jp">ヤフー</a>
<a href="http://facebook.com">http://facebook.com</a>
TEXT
text.scan(/<a href="(.+?)">\1<\/a>#=> [["http://google.com"], ["http://facebook.com"]]/)
#\1は（）でmキャプチャされた1番目の文字列と同じになる
#この場合では、(.+?)と\1は同じ

#-- ツイート、アカウント。ツイート日時を抽出する（メタ文字の複雑な組み合わせ） ---

You say yes. - @jnchito 8s
I say no. - @BarackObama 12m
You say stop. - @dhh 7h
I say go go go. - @ladygaga Feb 20
Hello, goodbye. - @BillGates 11 Apr 2015

#ツイートを抜き出す
(^.+) #文頭(^)から任意の1文字(.)を1個以上(+)
#アカウントを抜き出す
(@\w+) #@マークから英単語アンダースコア(\w)を1個以上(+)
#ツイート日時を抜き出し.1
#時間の表記がs,m,hの表記なので、[数字+s/m/h]という組み合わせになっている
(\d+[smh]) #数値(\d)を1個以上(+)とs/m/hのいずれか
#ツイート日時を抜き出し.2
(\w+{3} \d+) #=>これだと無駄にキャプチャしすぎているので以下に改良
([A-Z][a-z]{2} \d+) #AーZの大文字英字1文字＋a-zの小文字英字を2文字＋数値を1桁以上
#ツイート日時を抜き出し.3
(?:\d+ )?([A-Z][a-z]{2} \d+)
#(AB)? (CD)のように記述するとCDの前にABがあるかまいか？という意味になる。
#\d+の後にスペースが入れているのも注意

#全ての日時を一度に取り出す
(\d+[smh] | (?:\d+ )?[A-Z][a-z]{2} \d+)

#全ての項目を一気に取り出す
/^(.*) - (@\w+) (\d+[smh]|(?:\d+ )?[A-Z][a-z]{2} \d+)/
#=> [["You say yes.", "@jnchito", "8s"], ["I say no.", "@BarackObama", "12m"], ["You say stop.", "@dhh", "7h"], ["I say go go go.", "@ladygaga", "Feb 20"], ["Hello, goodbye.", "@BillGates", "11 Apr 2015"]]

#--- まとめ -----

# \bは単語の境界を表す
# (?=abc)は「abcという文字列の直前の位置」を表す（先読み）
# (?<=abc)は「abcという文字列の直後の位置」を表す（後読み）
# (?!abc)は「abcという文字列以外の直前の位置」を表す(否定の先読み)
# (?<!abc)は「abcという文字列以外の直後の位置」を表す(否定の先読み)
# キャプチャした文字列は正規表現内でも \1 や \2 といった連番で参照できる（後方参照）
# ? や * + といった量指定子は () の後ろにつけることができる
# |を使ったor検索では、各条件内でもメタ文字が使える
# 書き方によってはとんでもなく遅い正規表現ができてしまう場合もある
# メタ文字はバックスラッシュでエスケープする
# [] 内ではメタ文字の種類う使われる位置によって各文字の働きが異なる
# {n,} や {,n}はそれぞれ「直前の文字がn個以上、n個以下」の意味になる
# \W,\S,\D,\Bはそれぞれ\w,\s,\d,\bは単語の境界を表す逆の意味になる
# [] いずれか1文字を表す文字クラスを作る
# [^]〜以外の任意の1文字を表す
# - []内で使われると文字の範囲を表す
# . 任意の1文字を表す
# () 内部でマッチした文字列をキャプチャもしくはグループ化する
# ? 直前の文字やパターンが1回、もしくは0回現れる
# * 直前の文字やパターンが0回以上連続する
# + 直前の文字やぱたーんが1回以上連続する
# {n,m}直前の文字やパターンがn回以上、mかいいか連続する
# | or条件を作る
# ^ 行頭を表す
# $ 行末を表す
# \ メタ文字のエスケープ、\nや\wといった他のメタ文字の一部になったりする

# ----- 6.3 Rubyにおける正規表現オブジェクト ------

regex = /\d{3}-\d{4}
regex.class #=> regexp

#正規表現と文字列を比較する場合は=~がよく使われる
#正規表現がマッチした場合は文字列中のマッチした位置が返り、マッチしなかった場合はnilが返る

#マッチした場合はマッチした文字列の開始位置が返る（真）
'123-4567' =~ /\d{3}-\d{4}/ #=>0

#マッチしない場合はnilが返る(偽)
'hello' =~ /\d{3}-\d{4}/ #=>nil

#＝〜の戻り値はif文などでもよく使われる
if '123-4567' =~ /\d{3}-\d{4}/
	puts 'マッチしました'
else
	puts 'マッチしませんでした'
end
#=>マッチしました。

#左辺に正規表現を置いても結果は同じ
/\d{3}-\d{4}/ =~ '123-4567' #=>0
/\d{3}-\d{4}/ =~ 'hello' #=>nil

# !~を使うとマッチしなかった時にtrueをした時にfalseを返す
'hello' !~ /\d{3}-\d{4} #=>true

'私の誕生日は1977年7月17日です。'
\d+年\d月\d+日
(\d+)年(\d)月(\d+)日


text = '私の誕生日は1977年7月17日です。'
m = /(\d+)年(\d+)月(\d+)日/.match(text)
p m[1]
p m[2]
p m[3]

text = '私の誕生日は1977年7月17日です。'
#真偽値の判定とローカル変数への代入を同時に行う
if m = /(\d+)年(\d+)月(\d+)日/.match(text)
	#マッチした場合の処理（ローカル変数のmを使う）
else
	#マッチしなかった場合の処理
end

#MatchDateは[]を使って正規表現の処理結果を配列と同じような方法で取得できる
text = '私の誕生日は1977年7月17日です。'
m = /(\d+)年(\d+)月(\d+)日/.match(text)
#マッチした部分全体を取得する
m[0]
#キャプチャの1番目を取得
m[1]
#キャプチャの2番目から2個取得
m[2,2]
#最後のキャプチャを取得
m[-1]
#Rangeを使って取得する
m[1..3]

#matchメソッドはstringクラスとRegexpクラスの両方に定義されているため文字列と正規表現オブジェクトを入れ替えても同じように動作する
text = '私の誕生日は1977年7月17日です。'
m = text.match(/(\d+)年(\d)月(\d+)日/)

#キャプチャの結果に名前をつける
text ='私の誕生日は1977年7月17日です。'
m =/<?<year>\d)年(?<month>\d+)月(?<day>\d+)日/.match(text)

m[:year]
m[:month]
m[:day]

#連番で指定することもできる
m[2] #=>7

#
text = '私の誕生日は1977年7月17日です。'
#キャプチャの名前がそのままローカル変数に割り当てられる
if /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/ =~ text
	puts "#{year}/#{month}/#{day}"
end
#この機能は左辺と右辺を逆にすると使えない
#正規表現オブジェクトを一旦変数に入れ足した場合も使えない
text = '私の誕生日は1977年7月17日です。'
regexp = /(?<year)\d+)年(?<month>\d+)月(?<day>\d+)日/
#正規表現オブジェクトが変数に入ったりした場合も無効
if regexp =~ text
	puts "#{year}/#{month}/#{day}"
end
#=>NameError

# ---正規表現と組み合わせると便利なStringクラスのメソッド---

・scan
#scanメソッドは引数で渡した正規表現にマッチする部分を配列に入れて返す
'123 456 789'.scan(/\d+/) #=>[123,456,789]
#正規表現に()があるとキャプチャされた部分が配列の配列になって返ってくる
'1997年7月17日 2016年12月31日'.scan(/(\d+)年(\d+)月(\d+)日/)
#=> [["1997","7","17"],["2016,"12","31"]]
#グループ化はしたいがキャプチャはしたくない（マッチした文字列全体を取得したい）
'1997年7月17日 2016年12月31日'.scan(/(?:\d+)年(?:\d+)月(?:\d+)日/)
#上記のように取得したい場合は以下のようにシンプルにもかける
'1997年7月17日 2016年12月31日'.scan(/\d+年\d+月\d+日/)

・[],slice,slice!
#[]に正規表現を渡すと文字列から正規表現にマッチした部分を抜き出す
text = '郵便番号は123-4567'
text[/\d{3}-\d{4}/] #=>123-4567
#マッチする部分が複数ある場合は最初にマッチした文字列が返る
text = '123-4567 456-7890'
text[/\d{3}\d{4/}] #=>123-4567

#キャプチャを使って第二引数に取得するキャプチャを指定する
text = '誕生日は1977年7月17日です'

#第二引数がないとマッチした部分全体が返る
text[/(\d+)年(\d+)月(\d+)日/] #=>"1977年7月17日"

#第二引数をしてして3番目のキャプチャを取得する
text[\/d+]年(\d+)月(\d+)日/,3] #=> "17"

#名前付きキャプチャであれば名前で指定も可能
text = '誕生日は1977年7月17日です'
#シンボルでキャプチャの名前を指定する
text[/(?<year)\d+]年(?<month>\d+)月(?<day>\d+)日/, :day] #=> 17

#文字列でキャプチャの名前を指定する
text[/<?year>\d+]年(<month>\d+)月(?<day>\d+)日/, 'day'] #=>17

#sliceメソッドは[]のエイリアスメソッド
text = '郵便番号は123-4567'
text.slice(/\d{3}-\d{4}/) #123-4567
text = '誕生日は1977年7月17日です'
text.slice(/(\d+)年(\d+)月(\d+)日/,3) #=>17

#slice!にするとマッチした部分が文字列から破壊的に取り除かれる
text = '郵便番号は123-4567'
text.slice!(/\d{3}-\d{4}/) #"123-4567"
text #=>"郵便番号は"

・split
#splitに正規表現を渡すと、マッチした文字列を区切り文字にして文字列を分解し、配列として返す
text = '123,456-789'

#文字列で区切り文字を指定する
text.split(',') #=>["123", "456-789"]

#正規表現を使ってカンマまたはハイフンを区切り文字に指定する
text.split(/,|-/) #=> ["123","456","789"]


・gsub,gsub!
#gsubメソッドを使うと第1匹数の正規表現にマッチした文字列を第2引数の文字列で置き換える
text = '123,456-789'
#第1匹数に文字列を渡すと、完全一致する文字列を第2引数で置き換える
text.gsub(',',':') #=> "123:456-789"
#正規表現を渡すと、マッチした部分を第2引数で置き換える
text.gsub(/,|-/, ':') #=>123:456:789

#キャプチャを使うと第2引数で\1,\2のようにしてキャプチャした文字列を連番で参照できる
text = '私の誕生日は1977年7月17日です。'
text.gsub(/(\d+)年(\d+)月(\d+)日/,'\1-\2\-3') #=>"私の誕生日は1977-7-17です。"

#名前付きキャプチャの場合は\k<name>のように参照できる
text = "私の誕生日は1977年7月17日です。"
text.gsub(
	/(?<year>\d+)年(?<month>\d+)月(?<day>\d)日/,
	'\k<year>-\k<month>-\k<day>'
	)
#=>"私の誕生日は1977-7-17です。"

#第2引数にハッシュを渡して、変換のルールを指定することもできる
text = '123,456-789'
#カンマはコロンに、それ以外はスラッシュに置き換える
hash = { ',' => ':','-' => '/'}
text.gsub(/,|-/,hash) #=>123:456/789


#第2引数を渡す代わりにブロックの戻り値で置き換える文字列を指定できる
text = '123,456-789'
#カンマはコロンに、ハイフンはスラッシュに置き換える
p text.gsub(/,|-/) {|matched| matched == ',' ? ':' : '/' }
#=>"123:456/789"

#gsub!メソッドは文字列の内容を破壊的に置換する
text = '123,456-789'
text.gsub!(/,|-/,':')
text #=> "123:456:789"

# ----- Rubyのハッシュ記法を変換する -----

#キーがシンボルなら新しいハッシュ記法に変換する
old_syntax = <<TEXT
{
	:name => 'Alice',
	:age => 20,
	:gender => :female
}
TEXT
convert_hash_syntax(old_syntax)
# {
# 	name: 'Alice',
# 	age: 20,
# 	gender: :female
# }


#----- 正規表現オブジェクトについてもっと詳しく -----
#正規表現オブジェクトを作成する様々な方法

# // 以外にも正規表現オブジェクトがある
#1つはRegexp.new()の引数にパターンの文字列を渡す方法
#/\d{3}-\d{4}/と書いた場合と同じ
Regexp.new('\d{3}-\d{4}')

#もう一つは%rを使う方法(%方法)以下の3つの正規表現はどれも全く同じもの

#スラッシュで囲むとスラッシュをエスケープする必要がある
/http:\/\/example\.com/

#%rを使うとスラッシュをエスケープしなくて良い
%r!http://example\.com!

#!ではなく{}を区切り文字にする
%r{http://example\.com}

# //や%rの中で#{}を使うと変数の中身を展開することができる
pattern = '\d{3}-\{4}'
#変数が展開されるので/\d{3}-\{4}と書いたことと同じになる
'123-4567' =~ /#{pattern}/ #=> 0

#--case文で正規表現を使う --

text = '03-1234-5678'

case text
when /^\d{3}-\d{4}$/
	puts '郵便番号です'
when /^\d{4}\/\d{1,2}\/\d{1,2}$/
	puts '日付です'
when /^\d+-\d+-\d+$/
	puts '電話番号です'
end
#=>電話番号です。

#-- 正規表現オブジェクト作(税込)時のオプション

#iオプションをつけると大文字小文字を区別しない
'HELLO' =~ /hello/i #=0

#%rを使った場合も最後にオプションを付けられる
'HELLO' =~ %r{hello}i #=>0

#Regexp.newを使う場合はRegexp::IGNORECASEという定数を渡す
regexp = Rgexp.new('hello',Regexp::IGNORECASE)
'HELLO' =~ regexp #=>0

#mオプションを使うと任意の文字を表すドット(.)が改行文字にもマッチするようになる
"Hello\nBye" =~ /Hello.Bye/ #=>nil
"Hello\nBye" =~ /Hello.Bye/m #=> 0


#Regexp.newを使うときはRegexp::MULTILINEという定数を渡す
regexp = Regexp.new('hello.Bye',Regexp::MULTILINE)
"Hello\nBye" =~ regexp #=>0

# xオプションをつけたので改行やスペースが無視されてコメントもかける
regexp = /
	\d{3} #先頭の3桁
	-		#区切り線
	\d{4}
	/x
	'123-4567' =~ regexp #=> 0

#xオプションを付けている時に、空白を無視せず正規表現の一部として扱いたい場合はバックスラッシュでエスケープする
regexp = /
	\d{3}
	\ #=>半角スペースで区切る
	\d{4}
/x
'123 4567' =~ regexp #= 0

Regexp.newを使う場合はRegexp::EXETENDEDというs定数を渡す
#バックスラッシュを特別扱いしないように'TEXT'を使う
pattern = <<'TEXT'
 \d{3}
 -
 \d{4}
TEXT
regexp = Regexp.new(pattern,Rgexp::EXTENDED)
'123-4567' =~ regexp #=>0

#iとmオプションを両方使う
"HELLO\nBYE" =~ /HELLO.Bye/im

regexp = Regexp.new('Hello.Bye', Regexp::IGNORECASE | Regexp::MULTILINE)
"HELLO\nBYE" =~ regexp #=>0

#-- 組み込み変数でマッチの結果を取得する
text = '私の誕生日は1977年7月17日です。'

# =~やmatchメソッドを使うとマッチした結果が組み込み変数に代入される
text =~ /(\d+)年(\d+)月(\d+)日/

$~ #=> #<MatchData "1977年7月17日" 1:"1977" 2:"7" 3:"17">

#マッチした部分全体を取得する
$& #=>"1977年7月17日"

#1~3番目のキャプチャを取得する
$1 #=> "1977"
$2 #=> "7"
$3 #=> "17"

#最後のキャプチャ文字列を取得する
$+ #=>17

#Regexp.last_matchでマッチの結果を取得する
text = '私の誕生日は1977年7月17日です。'

# =-演算子などを使うと、マッチした結果をRgexp.last_matchで取得できる
text =~ /(\d+)年(\d+)月(\d+)日/

#Matchオブジェクトを取得する
Regexp.last_month(0) 

#1~3番目のキャプチャを取得する
Regexp.last_match(1)
Regexp.last_match(2)
Regexp.last_match(3)

Regexp.last_matsh(-1)


#組み込み変数を書き換えないmatch?メソッド

#マッチすればtrueを返す
/\d{3}-\s{4}/.match?('123-4567') #=> true

#マッチしても組み込み変数やRegexp.last_matchを書き換えない
# （）すでにどかで＝〜やmatchを使っていた場合はその時に設定された値になる

#文字列と正規表現を入れ替えてもOK
'123-4567'.match?(/\d{3}-\d{4}/) #=> true

