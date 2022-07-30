class Administrator < ApplicationRecord
    has_secure_password
    attr_accessor :current_password
    validates :password, presence: { if: :current_password }, length: { minimum: 6, maximum: 20, allow_blank: true }
end
