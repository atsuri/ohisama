0.upto(6) do |idx|
  if idx == 3
    Regular.create(
      item_id: 9,
      member_id: idx+1,
      regular_quantity: 0,
      update_at: "#{rand(1980..2000)}-12-01"
    )
  else
    Regular.create(
      item_id: 9,
      member_id: idx+1,
      regular_quantity: 1,
      update_at: "#{rand(1980..2000)}-12-01"
    )
  end
end

0.upto(6) do |idx|
  if idx == 4
    Regular.create(
      item_id: 10,
      member_id: idx+1,
      regular_quantity: 0,
      update_at: "#{rand(1980..2000)}-12-01"
    )
  else
    Regular.create(
      item_id: 10,
      member_id: idx+1,
      regular_quantity: 1,
      update_at: "#{rand(1980..2000)}-12-01"
    )
  end
end
  