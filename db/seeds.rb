# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |n|
  gimei = Gimei::Name.new
  Customer.create!(
  email: "test#{n}@test.com",
  password: "testpass",
  name: gimei.first.katakana,
  gender: "male",
  height: rand(120..190),
  age: rand(12..60),
  target_weight: rand(30..100),
  target_body_fat_percentage: rand(5..35),
  introduce: "男性です。よろしくおねがいします",
  profile_image_id: nil,
  diet_style1: true,
  diet_style3: true
  )
end

50.times do |n|
  gimei = Gimei::Name.new
  Customer.create!(
  email: "test#{n}@test2.com",
  password: "testpass",
  name: gimei.first.katakana,
  gender: "female",
  height: rand(120..190),
  age: rand(12..60),
  target_weight: rand(30..100),
  target_body_fat_percentage: rand(5..35),
  introduce: "女性です。よろしくおねがいします",
  profile_image_id: nil,
  diet_style2: true,
  diet_style4: true
  )
end

10.times do |n|
  Diary.create!(
    title: "ダイエットスタート",
    body: "早速、リングフィット4日目を午前中にやりました。
          実際に運動した時間は10分くらいだけど、汗だくだく。
          お腹系の筋トレばっかやってみました！",
    weight: rand(60..90),
    body_fat_percentage: rand(15..30),
    food_calorie: rand(2000..3000),
    activity_calorie: rand(2000..3000),
    post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
    customer_id: 100
  )

  Diary.create!(
    title: "ダイエット５日目",
    body: "ダイエット５日目になりました。
          なんでこんなに落ちないんだろ？。
          食事を見直そうと思います・・・",
    weight: rand(60..90),
    body_fat_percentage: rand(15..30),
    food_calorie: rand(2000..3000),
    activity_calorie: rand(2000..3000),
    post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
    customer_id: 99
  )

  Diary.create!(
    title: "今日のお食事",
    body: "朝食・・・　チーズトースト（食パン、チーズ、ブルーベリージャム）
          昼食・・・　　豆乳パスタ（パスタ、豆乳、キャベツ、パセリ、ミートボール、
          夕食・・・　　白米＆もち麦ご飯、麻婆豆腐、焼きサンマ、",
    weight: rand(60..90),
    body_fat_percentage: rand(15..30),
    food_calorie: rand(2000..3000),
    activity_calorie: rand(2000..3000),
    post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
    customer_id: 98
  )

  Diary.create!(
    title: "今日の食事：1154kcal",
    body: "毎日の目標 1. カロリー：1300kcal 以下　→　○
          2. タンパク質：55g 以上　→　×
          3. ファスティング：14時間 以上　→　○",
    weight: rand(60..90),
    body_fat_percentage: rand(15..30),
    food_calorie: rand(2000..3000),
    activity_calorie: rand(2000..3000),
    post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
    customer_id: 97
  )

  Diary.create!(
    title: "増えてなくて一安心",
    body: "一気に目標達成するため丸一日主食を抜くつもりでいたのに、
          誘惑に負けて餃子をたらふく食べてしまった。
          あとマイナス0.2。今日こそがんばろう。",
    weight: rand(60..90),
    body_fat_percentage: rand(15..30),
    food_calorie: rand(2000..3000),
    activity_calorie: rand(2000..3000),
    post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
    customer_id: 96
  )

  Diary.create!(
    title: "更新しました。",
    body: "76kg台、定着してきた様子。
          あと少しで76kg切れそうだけど、多分、ここから頑張らないと行けそうで行けない気がする。
          今日はたくさん歩いてくるぞー！",
    weight: rand(60..90),
    body_fat_percentage: rand(15..30),
    food_calorie: rand(2000..3000),
    activity_calorie: rand(2000..3000),
    post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
    customer_id: 95
  )
end
Diary.create!(
  title: "ダイエットスタート",
  body: "早速、リングフィット4日目を午前中にやりました。
        実際に運動した時間は10分くらいだけど、汗だくだく。
        お腹系の筋トレばっかやってみました！",
  weight: rand(60..90),
  body_fat_percentage: rand(15..30),
  food_calorie: rand(2000..3000),
  activity_calorie: rand(2000..3000),
  post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
  customer_id: 100
)

Diary.create!(
  title: "ダイエット５日目",
  body: "ダイエット５日目になりました。
        なんでこんなに落ちないんだろ？。
        食事を見直そうと思います・・・",
  weight: rand(60..90),
  body_fat_percentage: rand(15..30),
  food_calorie: rand(2000..3000),
  activity_calorie: rand(2000..3000),
  post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
  customer_id: 99
)

Diary.create!(
  title: "今日のお食事",
  body: "朝食・・・　チーズトースト（食パン、チーズ、ブルーベリージャム）
        昼食・・・　　豆乳パスタ（パスタ、豆乳、キャベツ、パセリ、ミートボール、
        夕食・・・　　白米＆もち麦ご飯、麻婆豆腐、焼きサンマ、",
  weight: rand(60..90),
  body_fat_percentage: rand(15..30),
  food_calorie: rand(2000..3000),
  activity_calorie: rand(2000..3000),
  post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
  customer_id: 98
)

Diary.create!(
  title: "今日の食事：1154kcal",
  body: "毎日の目標 1. カロリー：1300kcal 以下　→　○
        2. タンパク質：55g 以上　→　×
        3. ファスティング：14時間 以上　→　○",
  weight: rand(60..90),
  body_fat_percentage: rand(15..30),
  food_calorie: rand(2000..3000),
  activity_calorie: rand(2000..3000),
  post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
  customer_id: 97
)

Diary.create!(
  title: "増えてなくて一安心",
  body: "一気に目標達成するため丸一日主食を抜くつもりでいたのに、
        誘惑に負けて餃子をたらふく食べてしまった。
        あとマイナス0.2。今日こそがんばろう。",
  weight: rand(60..90),
  body_fat_percentage: rand(15..30),
  food_calorie: rand(2000..3000),
  activity_calorie: rand(2000..3000),
  post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
  customer_id: 96
)

Diary.create!(
  title: "更新しました。",
  body: "76kg台、定着してきた様子。
        あと少しで76kg切れそうだけど、多分、ここから頑張らないと行けそうで行けない気がする。
        今日はたくさん歩いてくるぞー！",
  weight: rand(60..90),
  body_fat_percentage: rand(15..30),
  food_calorie: rand(2000..3000),
  activity_calorie: rand(2000..3000),
  post_date: "2021-#{rand(1..12)}-#{rand(1..28)}",
  customer_id: 95
)

DiaryImage.create!(diary_id: 61, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DiaryImage.create!(diary_id: 61, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DiaryImage.create!(diary_id: 61, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DiaryImage.create!(diary_id: 62, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DiaryImage.create!(diary_id: 62, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DiaryImage.create!(diary_id: 62, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DiaryImage.create!(diary_id: 63, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DiaryImage.create!(diary_id: 63, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DiaryImage.create!(diary_id: 63, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DiaryImage.create!(diary_id: 64, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DiaryImage.create!(diary_id: 64, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DiaryImage.create!(diary_id: 64, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DiaryImage.create!(diary_id: 65, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DiaryImage.create!(diary_id: 65, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DiaryImage.create!(diary_id: 65, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DiaryImage.create!(diary_id: 66, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DiaryImage.create!(diary_id: 66, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DiaryImage.create!(diary_id: 66, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))


10.times do |n|
  DietMethod.create!(
    title: "おからダイエット",
    way: "おからダイエットとは、食生活に「おから」を取り入れることにより、満腹感の向上やカロリーを抑えることを目的としたダイエット方法です。
          おからの炭水化物は、ほとんどがカロリーの少ない食物繊維。腸内の掃除をして、糖質や脂質などの吸収を抑えます。カロリーは同量のごはんとくらべると31%も低くなります。茶碗1膳分（約150g）の白いごはんを食べた場合、カロリーは252kcal。一食の献立を500kcal以内にしようとすると、通常はごはんだけでカロリーの半分を占めるということになります。
          大豆を煮てすりつぶし、こしたものが「豆乳」。残ったかすが「おから」。豆乳ににがりなどを加えて固めたものが「豆腐」です。おからは、お豆腐屋さんで売っている旧製法の水分が多いタイプと、スーパーなどで見かける水分が少ない新製法のタイプがあります。タイプに合わせて調理のときの水分や調味料の量を調整します。",
    attention: "栄養バランスに注意しましょう",
    customer_id: 100
  )

  DietMethod.create!(
    title: "1日5食ダイエット",
    way: "「なんでこんなに食べちゃったんだろう・・・」と思ったことがある人に！
          見直すべきはカロリーより「食べ癖」
          偏った食べ方を改善する事が痩せやすいカラダへの第一歩！

          「心配はいりません。いっぱい食べて、ストレスを解消しているんだ!と前向きにとらえて」",
    attention: "食べすぎに注意しましょう",
    customer_id: 99
  )

  DietMethod.create!(
    title: "糖質制限ダイエット",
    way: "糖質制限ダイエットとは、食事から糖質を極力制限するダイエット。

          ご飯・パン・イモ類といった炭水化物はもちろん、果物も制限する。
          また、調味料として含まれる砂糖も控えめにする。
          ※自宅で料理するときにはラカントＳなどの甘味料商品を使う",
    attention: "食事は肉・魚・野菜を中心に組み立て、甘い味付けは控える。",
    customer_id: 98
  )

  DietMethod.create!(
    title: "筋トレ",
    way: "筋肥大を行うため、高負荷なトレーニングを行う。
          目安としては、全力で行って8~12回程度しか出来ないような負荷を筋肉に与える。

          【休養】
          筋肉に高負荷をかけると、損傷する。
          損傷した筋肉は時間が立つと回復。
          さらに時間が立つと、余計に回復（超回復）。
          超回復期にトレーニングを行うとさらに筋力がアップ。
          つまり、超回復までは、筋肉をしっかりと休養させる必要がある。
  ",
    attention: "食事は肉・魚・野菜を中心に組み立て、甘い味付けは控える。",
    customer_id: 97
  )

  DietMethod.create!(
    title: "水泳ダイエット",
    way: "水泳は全身運動のため、有酸素運動の中でも他の運動に比べて消費カロリーが高い運動。

          また、ウォーキングやランニングと比べ、腰やひざにかかる負担が少ないダイエット方法。

          泳ぎが苦手な方は、水中ウォーキングだけでも効果が期待できる。",
    attention: "食事は肉・魚・野菜を中心に組み立て、甘い味付けは控える。",
    customer_id: 96
  )

  DietMethod.create!(
    title: "計るだけダイエット",
    way: "1日に朝と夜などの複数回、体重を計りグラフ化して体重管理をするというダイエット方法。",
    attention: "特になし",
    customer_id: 96
  )
end

DietMethod.create!(
  title: "おからダイエット",
  way: "おからダイエットとは、食生活に「おから」を取り入れることにより、満腹感の向上やカロリーを抑えることを目的としたダイエット方法です。
        おからの炭水化物は、ほとんどがカロリーの少ない食物繊維。腸内の掃除をして、糖質や脂質などの吸収を抑えます。カロリーは同量のごはんとくらべると31%も低くなります。茶碗1膳分（約150g）の白いごはんを食べた場合、カロリーは252kcal。一食の献立を500kcal以内にしようとすると、通常はごはんだけでカロリーの半分を占めるということになります。
        大豆を煮てすりつぶし、こしたものが「豆乳」。残ったかすが「おから」。豆乳ににがりなどを加えて固めたものが「豆腐」です。おからは、お豆腐屋さんで売っている旧製法の水分が多いタイプと、スーパーなどで見かける水分が少ない新製法のタイプがあります。タイプに合わせて調理のときの水分や調味料の量を調整します。",
  attention: "栄養バランスに注意しましょう",
  customer_id: 100
)

DietMethod.create!(
  title: "1日5食ダイエット",
  way: "「なんでこんなに食べちゃったんだろう・・・」と思ったことがある人に！
        見直すべきはカロリーより「食べ癖」
        偏った食べ方を改善する事が痩せやすいカラダへの第一歩！

        「心配はいりません。いっぱい食べて、ストレスを解消しているんだ!と前向きにとらえて」",
  attention: "食べすぎに注意しましょう",
  customer_id: 99
)

DietMethod.create!(
  title: "糖質制限ダイエット",
  way: "糖質制限ダイエットとは、食事から糖質を極力制限するダイエット。

        ご飯・パン・イモ類といった炭水化物はもちろん、果物も制限する。
        また、調味料として含まれる砂糖も控えめにする。
        ※自宅で料理するときにはラカントＳなどの甘味料商品を使う",
  attention: "食事は肉・魚・野菜を中心に組み立て、甘い味付けは控える。",
  customer_id: 98
)

DietMethod.create!(
  title: "筋トレ",
  way: "筋肥大を行うため、高負荷なトレーニングを行う。
        目安としては、全力で行って8~12回程度しか出来ないような負荷を筋肉に与える。

        【休養】
        筋肉に高負荷をかけると、損傷する。
        損傷した筋肉は時間が立つと回復。
        さらに時間が立つと、余計に回復（超回復）。
        超回復期にトレーニングを行うとさらに筋力がアップ。
        つまり、超回復までは、筋肉をしっかりと休養させる必要がある。
",
  attention: "食事は肉・魚・野菜を中心に組み立て、甘い味付けは控える。",
  customer_id: 97
)

DietMethod.create!(
  title: "水泳ダイエット",
  way: "水泳は全身運動のため、有酸素運動の中でも他の運動に比べて消費カロリーが高い運動。

        また、ウォーキングやランニングと比べ、腰やひざにかかる負担が少ないダイエット方法。

        泳ぎが苦手な方は、水中ウォーキングだけでも効果が期待できる。",
  attention: "食事は肉・魚・野菜を中心に組み立て、甘い味付けは控える。",
  customer_id: 96
)

DietMethod.create!(
  title: "計るだけダイエット",
  way: "1日に朝と夜などの複数回、体重を計りグラフ化して体重管理をするというダイエット方法。",
  attention: "特になし",
  customer_id: 96
)

DietMethodImage.create!(diet_method_id: 61, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DietMethodImage.create!(diet_method_id: 61, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DietMethodImage.create!(diet_method_id: 61, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DietMethodImage.create!(diet_method_id: 62, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DietMethodImage.create!(diet_method_id: 62, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DietMethodImage.create!(diet_method_id: 62, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DietMethodImage.create!(diet_method_id: 63, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DietMethodImage.create!(diet_method_id: 63, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DietMethodImage.create!(diet_method_id: 63, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DietMethodImage.create!(diet_method_id: 64, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DietMethodImage.create!(diet_method_id: 64, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DietMethodImage.create!(diet_method_id: 64, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DietMethodImage.create!(diet_method_id: 65, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DietMethodImage.create!(diet_method_id: 65, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))
DietMethodImage.create!(diet_method_id: 65, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DietMethodImage.create!(diet_method_id: 66, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample3.jpg"))
DietMethodImage.create!(diet_method_id: 66, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample2.jpg"))
DietMethodImage.create!(diet_method_id: 66, image: File.open("/home/ec2-user/PF-dieter/app/assets/images/sample1.jpg"))

CheckList.create!(
  diet_method_id: 61,
  body: "朝ごはんをおからにする"
)
CheckList.create!(
  diet_method_id: 62,
  body: "食べすぎないようにする"
)
CheckList.create!(
  diet_method_id: 63,
  body: "朝ごはんの炭水化物を抜く"
)
CheckList.create!(
  diet_method_id: 63,
  body: "昼ごはんの炭水化物を抜く"
)
CheckList.create!(
  diet_method_id: 63,
  body: "よるごはんの炭水化物を抜く"
)
CheckList.create!(
  diet_method_id: 64,
  body: "毎日ジムでトレーニング"
)
CheckList.create!(
  diet_method_id: 65,
  body: "毎日水泳"
)
CheckList.create!(
  diet_method_id: 66,
  body: "毎朝体重をはかる"
)


999.times do |n|
  LevelSetting.create!(
    level: n + 2,
    threshold: 10 + n * 10
  )
end

Admin.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'])

Achievement.create!(
  title: "ダイエッターにようこそ！",
  description: "新規登録を完了する",
  difficulty: 1,
  batch: "fas fa-seedling"
)

Achievement.create!(
  title: "決意表明",
  description: "はじめてダイエット方法を投稿する",
  difficulty: 1,
  batch: "fas fa-biking"
)

Achievement.create!(
  title: "成功への第一歩",
  description: "はじめて日記を投稿する",
  difficulty: 1,
  batch: "fas fa-list-alt"
)

Achievement.create!(
  title: "いっしょに頑張りましょう！",
  description: "はじめてユーザーをフォローする",
  difficulty: 1,
  batch: "far fa-handshake"
)

Achievement.create!(
  title: "参考にさせていただきます！",
  description: "はじめて他ユーザーのダイエット方法を実践する",
  difficulty: 1,
  batch: "fas fa-pray"
)

Achievement.create!(
  title: "いいね！いいね！いいね！",
  description: "日記かダイエット方法に合計5回いいねする",
  difficulty: 2,
  batch: "fas fa-hand-holding-heart"
)

Achievement.create!(
  title: "グッドコミュニケーション",
  description: "日記かダイエット方法に合計5個コメントする",
  difficulty: 2,
  batch: "far fa-comment-alt"
)

Achievement.create!(
  title: "今日は記録だけ…",
  description: "はじめてクイック投稿から日記を作成する",
  difficulty: 2,
  batch: "far fa-smile-wink"
)

Achievement.create!(
  title: "仲良くしましょう！",
  description: "はじめて個人チャットルームを作成する",
  difficulty: 2,
  batch: "far fa-comments"
)

Achievement.create!(
  title: "検索を活用しよう！",
  description: "はじめて検索機能を利用する",
  difficulty: 2,
  batch: "fas fa-search"
)

Achievement.create!(
  title: "三日坊主卒業",
  description: "日記を5回投稿",
  difficulty: 3,
  batch: "fas fa-chess-pawn"
)

Achievement.create!(
  title: "努力家",
  description: "日記を25回投稿",
  difficulty: 4,
  batch: "fas fa-chess-rook"
)

Achievement.create!(
  title: "努力の天才",
  description: "日記を50回投稿",
  difficulty: 5,
  batch: "fas fa-chess-king"
)

Achievement.create!(
  title: "おめでとうございます！",
  description: "目標体重を達成する",
  difficulty: 5,
  batch: "fas fa-flag-checkered"
)

Achievement.create!(
  title: "隠れ○○○○",
  description: "隠れダンベルをクリックする「ヒント：画面上部のどこか」",
  difficulty: 5,
  batch: "fas fa-dumbbell"
)