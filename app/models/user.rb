class User < ActiveRecord::Base
  before_save :downcase_email
	validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  has_secure_password
  def downcase_email 
    self.email = email.downcase 
  end
end
