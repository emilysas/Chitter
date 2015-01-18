ENV['RACK_ENV'] = 'test' # tells us which database to work with

require './app/server.rb' #needs to be after the env so that the server knows 
# which environment it's running in
require './spec/helpers/user_experience_methods'
require 'database_cleaner'
require 'capybara/rspec'
require "rack/flash/test"

Capybara.app = Chitter

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
