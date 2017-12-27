class Employee < ApplicationRecord
    attr_accessor :remember_token

    validates :name, presence: true, length: { maximum: 30 }
    validates :designation, presence: true
    
    before_save { email.downcase! }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.([a-z]){2,3}+){1,2}\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    
    PHONE_REGEX = /\A([0-9]+){10}\z/
    validates :phone, format: {with: PHONE_REGEX}, uniqueness: true

    validates :date_of_join, presence: true
    validates :address, presence: true, length: { minimum: 21, maximum: 255 }

    has_secure_password
    VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[\W])(?=.*[\d])[\S]{8,15}\z/
    validates :password, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true


    

      # Returns the hash digest of the given string.
  def Employee.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

    # Returns a random token.
  def Employee.new_token
    SecureRandom.urlsafe_base64
  end

    # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Employee.new_token
    update_attribute(:remember_digest, Employee.digest(remember_token))
  end

    # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
    # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end