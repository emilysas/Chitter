require 'bcrypt'


class User

  class Relationship

    include DataMapper::Resource

    belongs_to :follower, 'User', :key => true
    belongs_to :followed, 'User', :key => true

  end

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

  has n, :peeps, :through => Resource
  has n, :replies, :through => Resource

  has n, :relationships_to_followed_users, 'User::Relationship', :child_key => [ :follower_id ]
  has n, :relationships_to_followers, 'User::Relationship', :child_key => [ :followed_id ]

  has n, :followed_users, self, 
    :through => :relationships_to_followed_users,
    :via     => :followed

  has n, :followers, self,
    :through => :relationships_to_followers,
    :via     => :follower
  
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

  def follow(user)
    User::Relationship.create(:followed => user, :follower => self)
  end

  # def unfollow(others)
  #   relationships_to_followed_users.all(:followed => Array(others)).destroy!
  #   reload
  #   self
  # end

end
