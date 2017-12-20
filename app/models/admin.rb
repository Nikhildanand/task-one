class Admin < ApplicationRecord
  attr_accessor :remember_token
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

  # Returns a random token.
  def Admin.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Admin.new_token
    update_attribute(:remember_digest, Admin.digest(remember_token))
  end
  # Returns true if the given token matches thdigest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end