class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :member, null: false
      t.integer :order_quantity
      t.integer :date
      t.integer :time_limit
      t.integer :status
      t.datetime :order_time

      t.timestamps
    end
  end
end
