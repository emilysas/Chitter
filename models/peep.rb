

class Peep

  include DataMapper::Resource

  property :id,              Serial
  property :posted_by,       String,  :required => true
  property :content,         Text,    :required => true, :length   => 155
  property :created_at,      Time,    :required => true
  property :favourites,      Integer
  property :re_peeps,        Integer

  # has n, :authorships
  # belongs_to :user, :through => :authorships
  belongs_to :user
end



