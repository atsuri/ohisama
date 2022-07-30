class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :category, null: false #外部キー
      t.string :item_name, null: false #アイテム名
      t.integer :price, null: false #値段
      t.integer :item_quantity, null: false #個数
      t.boolean :disable, null: false, default: false #欠品かどうか

      t.timestamps
    end
  end
end
