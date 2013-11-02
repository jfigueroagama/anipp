RSpec.configure do |config|

  # This cleans the test database completly
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # This sets the default strategy to transactions
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # This line runs before examples that are been tagged as :js => true
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  # The following two hook up database_cleaner at the beginning and end of each test
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end