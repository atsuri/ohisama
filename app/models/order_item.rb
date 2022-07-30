class OrderItem < ApplicationRecord
    belongs_to :item
    belongs_to :order

    # validates :orderitem_quantity, presence: true,
    #     numericality: {
    #         only_integer: true,
    #         greater_than: 0,#1以上
    #         allow_blank: true
    #     }
end
