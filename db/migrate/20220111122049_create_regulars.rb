class CreateRegulars < ActiveRecord::Migration[5.2]
  def change
    create_table :regulars do |t|
      t.references :item, null: false
      t.references :member
      t.integer :regular_quantity, null: false
      t.datetime :update_at

      t.timestamps
    end
  end
end
