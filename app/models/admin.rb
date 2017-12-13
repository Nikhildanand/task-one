class Admin < ApplicationRecord
    validates :name, presence: true, length: {minimum:4, maximum:50}, uniqueness: true
    has_secure_password
    VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[\W])(?=.*[\d])[\S]{8,15}\z/
    validates :password, format: { with: VALID_PASSWORD_REGEX }
end