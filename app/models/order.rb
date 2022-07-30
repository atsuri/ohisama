class Order < ApplicationRecord
    has_many :order_items, dependent: :destroy
    has_many :items, through: :order_items

    belongs_to :member

    validates :status, presence: true,
      numericality: {
        only_integer: true,
        greater_than: 0,#1以上
        allow_blank: true
      }
end
