0.upto(6) do |idx|
    OrderItem.create(
        order_id: idx+1,
        item_id: 9,
        orderitem_regular: true,
        orderitem_quantity: 1,
        orderitem_price: 100,
        orderitem_name: "牛乳"
    )
end

0.upto(6) do |idx|
    OrderItem.create(
        order_id: idx+1,
        item_id: 10,
        orderitem_regular: true,
        orderitem_quantity: 2,
        orderitem_price: 110,
        orderitem_name: "卵"
    )
end