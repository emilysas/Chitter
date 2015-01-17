require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,              Serial
  property :name,            String
  property :username,        String, :unique => true, :message => "This username is already taken"
  property :email,           String, :unique => true, :message => "This email is already taken"
  property :password_digest, Text

  validates_uniqueness_of :username
  validates_uniqueness_of :email

  attr_reader   :password
  attr_accessor :password_confirmation

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
