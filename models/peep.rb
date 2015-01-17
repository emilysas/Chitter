

class Peep

  include DataMapper::Resource

  property :id,              Serial
  property :posted_by,       String,  :required => true
  property :content,         Text,    :required => true
  property :created_at,      Time,    :required => true
  property :favourites,      Integer
  property :re_peeps,        Integer

  belongs_to :user
end
