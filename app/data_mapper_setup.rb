require './models/user'
require './models/peep'
require './models/authorship'

env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. bookmark_manager_test/development
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")


# After declaring your modesl, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!