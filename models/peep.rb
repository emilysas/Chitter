require './app/helpers/ago'

class Peep

  include DataMapper::Resource
  include Ago

  property :id,              Serial
  property :posted_by,       String,  :required => true
  property :content,         Text,    :required => true, :length   => 155
  property :created_at,      Time,    :required => true
  property :favourites,      Integer, :default => 0
  property :re_peeps,        Integer

  belongs_to :user
  has n, :replies, :through => Resource

  def self.all_in_chron
    self.all.sort {|a,b|b.created_at <=> a.created_at}
  end

  def self.all_by_user_in_chron(username)
    self.all(:posted_by => username).sort {|a,b|b.created_at <=> a.created_at}
  end


end





