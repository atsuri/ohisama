names = %w(ヨーグルト まぐろ ハム 抹茶アイス 餃子 白米 ティッシュ 化粧水)
# デイリー食品 生鮮 加工食品 飲料・菓子・アイス 冷凍食品 お米・お酒 日用品 化粧品
0.upto(7) do |idx|
  Item.create(
    category_id: idx+1,
    item_name: names[idx],
    price: 100 + idx*10,
    item_quantity: 101,
    disable: false
  )
end

regular = %w(牛乳 卵)
0.upto(1) do |idx|
    Item.create(
        category_id: 1,
        item_name: regular[idx],
        price: 100 + idx*10,
        item_quantity: 101,
        disable: false
    )
end

seisen = %w(豚肉 鶏肉 牛肉 しゃけ イカ)
0.upto(4).each do |item|
  Item.create(
    category_id: 2,
    item_name: seisen[item],
    price: 100 + item*10,
    item_quantity: 101,
    disable: false
  )
end

kakou = %w(ウィンナー ベーコン ハンバーグ)
0.upto(2).each do |item|
  Item.create(
    category_id: 3,
    item_name: kakou[item],
    price: 100 + item*10,
    item_quantity: 101,
    disable: false
  )
end

kashi = %w(お茶 水 バニラアイス ポテトチップス チョコレート)
0.upto(4).each do |item|
  Item.create(
    category_id: 4,
    item_name: kashi[item],
    price: 100 + item*10,
    item_quantity: 101,
    disable: false
  )
end

reito = %w(ピザ シューマイ パスタ ブロッコリー うどん)
0.upto(4).each do |item|
  Item.create(
    category_id: 5,
    item_name: reito[item],
    price: 100 + item*10,
    item_quantity: 101,
    disable: false
  )
end

okome = %w(雑穀米 玄米 焼酎 ワイン)
0.upto(3).each do |item|
  Item.create(
    category_id: 6,
    item_name: okome[item],
    price: 100 + item*10,
    item_quantity: 101,
    disable: false
  )
end

nichi = %w(食器洗剤 洗濯洗剤 トイレットペッパー 歯磨き粉 歯ブラシ)
0.upto(4).each do |item|
  Item.create(
    category_id: 7,
    item_name: nichi[item],
    price: 100 + item*10,
    item_quantity: 101,
    disable: false
  )
end

kesho = %w(パック リップ ファンデーション アイシャドウ 乳液)
0.upto(4).each do |item|
  Item.create(
    category_id: 8,
    item_name: kesho[item],
    price: 100 + item*10,
    item_quantity: 101,
    disable: false
  )
end