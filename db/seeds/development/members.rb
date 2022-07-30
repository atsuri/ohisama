userID = %w(userid1 userid2 userid3 userid4 userid5 userid6 userid7)
names = %w(テスト1 テスト2 テスト3 テスト4 テスト5 テスト6 テスト7)
address = ["東京", "神奈川", "茨城", "千葉", "埼玉", "栃木", "群馬"]
group = [1,3,5]
0.upto(6) do |idx|
    if idx==6 #定期便頼んでる頼んでないを決めるため
        Member.create!(
            user_id: userID[idx],
            name: names[idx],
            address: address[idx],
            regular_member: false,
            group: group[idx % 3],
            password: "ohisama",
            password_confirmation: "ohisama"
          )
    else
        Member.create!(
            user_id: userID[idx],
            name: names[idx],
            address: address[idx],
            regular_member: true,
            group: group[idx % 3],
            password: "ohisama",
            password_confirmation: "ohisama"
        )
    end
end
