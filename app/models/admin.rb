class Admin < ApplicationRecord
    validates :name, presence: true, length: {minimum:4, maximum:50}, uniqueness: true
    has_secure_password
    VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[\W])(?=.*[\d])[\S]{8,15}\z/
    validates :password, format: { with: VALID_PASSWORD_REGEX }
  
    # Returns the hash digest of the given string.
  def Admin.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end