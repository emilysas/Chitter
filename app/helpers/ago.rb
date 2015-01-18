module Ago
  def when(time)
    diff = Time.now - time
    diff_in_mins = (diff/60).to_i
    timeframe(diff_in_mins)
  end

  def timeframe(time)
    case 
      when time == 1 then timestamp ="1 minute ago" 
      when time == 0 then timestamp = "Under a minute ago"
      when time > 1440 then timestamp = "#{time/1440} days ago" 
      when time > 60 then timestamp = "#{time/60} hour ago"
      when time > 120 then timestamp = "#{time/60} hours ago"
      when time < 60 then timestamp ="#{time} minutes ago"
    end
    timestamp
  end
end