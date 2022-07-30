class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :user_id, null: false #ユーザid
      t.string :name, null: false #ユーザ名
      t.string :address, null: false #住所
      t.boolean :regular_member, default: false #定期頼んでるか
      t.integer :group, null: false #配送グループ

      t.timestamps
    end
  end
end
