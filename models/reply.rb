require './app/helpers/ago'

class Reply

  include DataMapper::Resource
  include Ago

  property :id,              Serial
  property :posted_by,       String,  :required => true
  property :content,         Text,    :required => true, :length   => 155
  property :created_at,      Time,    :required => true
  property :favourites,      Integer
  property :re_peeps,        Integer

  belongs_to :user
  belongs_to :peep

end