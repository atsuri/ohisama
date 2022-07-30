class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :item
      t.boolean :orderitem_regular, default: false
      t.boolean :orderitem_cancel, default: false
      t.integer :orderitem_quantity
      t.integer :orderitem_price
      t.string :orderitem_name

      t.timestamps
    end
  end
end
