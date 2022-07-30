# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_19_072123) do

  create_table "administrators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "item_name", null: false
    t.integer "price", null: false
    t.integer "item_quantity", null: false
    t.boolean "disable", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.boolean "regular_member", default: false
    t.integer "group", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "item_id"
    t.boolean "orderitem_regular", default: false
    t.boolean "orderitem_cancel", default: false
    t.integer "orderitem_quantity"
    t.integer "orderitem_price"
    t.string "orderitem_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "order_quantity"
    t.integer "date"
    t.integer "time_limit"
    t.integer "status"
    t.datetime "order_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_orders_on_member_id"
  end

  create_table "regulars", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "member_id"
    t.integer "regular_quantity", null: false
    t.datetime "update_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_regulars_on_item_id"
    t.index ["member_id"], name: "index_regulars_on_member_id"
  end

end
