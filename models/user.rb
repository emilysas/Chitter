require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,              Serial
  property :name,            String, :required => true
  property :username,        String, :required => true, :unique => true, :message => "This username is already taken"
  property :email,           String, :required => true, :unique => true, :message => "This email is already taken"
  property :password_digest, Text

  has n, :peeps, :through => Resource

  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_confirmation_of :password

  attr_reader   :password
  attr_accessor :password_confirmation

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    user = first(:username => username)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end
