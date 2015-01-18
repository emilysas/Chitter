

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

  def when(time) 
    diff = Time.now - time
    diff_in_mins = (diff/60).to_i
    timeframe(diff_in_mins)
  end

  def timeframe(time)
    case 
      when time > 1440 then timestamp = "#{time/1440} days ago" 
      when time > 60 then timestamp = "#{time/60} hours ago" 
      when time < 60 then timestamp ="#{time} minutes ago" 
    end
    timestamp
  end

end





