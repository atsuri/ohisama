class Member < ApplicationRecord
  has_many :regulars, dependent: :destroy

  has_many :orders, dependent: :destroy

  has_secure_password

  attr_accessor :current_password
  validates :password, presence: { if: :current_password }, 
    confirmation: true,
    format: {
      with: /\A[A-Za-z][A-Za-z0-9]*\z/,
      allow_blank: true
    }, 
    length: { minimum: 6, maximum: 20, allow_blank: true }

  validates :user_id, presence: true, length: { minimum: 1, maximum: 20, allow_blank: true }, uniqueness: true
  validates :name, presence: true,
    length: { minimum: 1, maximum: 10, allow_blank: true}
  validates :group, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,#1以上
      allow_blank: true
    }
  validates :address, presence: true, length: { minimum: 1, maximum: 20, allow_blank: true }

  class << self
    def search(query)
      rel = order("name")
      if query.present?
        rel = rel.where("name LIKE ?","%#{query}%")
      end
      rel
    end
  end
end
