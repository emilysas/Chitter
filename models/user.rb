require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,              Serial

  property :name,            String,  :required => true

  property :username,        String,  :required => true, 
                                      :unique   => true, 
                                      :messages => {:presence  => "Please provide a username",
                                                    :is_unique => "This username is already taken"}
  
  property :email,           String,  :required => true, 
                                      :format   => :email_address, 
                                      :unique   => true, 
                                      :messages => {:presence  => "Please provide an email address",
                                                    :is_unique => "This email is already taken",
                                                    :format    => "Please provide a valid email address"}
  
  property :password_digest, Text

  # has n,   :authorships
  # has n,   :peeps, :through => :authorships
  has n, :peeps, :through => Resource

  validates_uniqueness_of   :username
  validates_uniqueness_of   :email
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
