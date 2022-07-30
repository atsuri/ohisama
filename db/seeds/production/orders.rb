0.upto(6) do |idx|
    Order.create(
        member_id: idx+1,
        status: 1
    )
end