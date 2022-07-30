class Item < ApplicationRecord
    belongs_to :category

    has_many :order_items
    has_many :orders, through: :order_items

    has_many :regulars

    validates :price, presence: true, 
      numericality: {
        only_integer: true,
        greater_than: 0,
        allow_blank: true
      }
    validates :item_quantity, presence: true, 
      numericality: {
        only_integer: true,
        greater_than_or_equal_to: 1,
        allow_blank: true
      }
    validates :item_name, presence: true, length: { minimum: 1, allow_blank: true }

    class << self
        def search(query)
          rel = order("item_name")
          if query.present?
            rel = rel.where("item_name LIKE ?","%#{query}%")
          end
          rel
        end
    end

end
