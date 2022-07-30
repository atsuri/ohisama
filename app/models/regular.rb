class Regular < ApplicationRecord
  belongs_to :member
  belongs_to :item

  scope :search, -> (keyword) {
    where('name like :q OR item_name like :item', q: "%#{keyword}%", item_name: "%#{keyword}%") if keyword.present?
  }

  validates :regular_quantity, presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,#0以上
      less_than_or_equal_to: 5,#5以下
      allow_blank: true
    }
end
