require 'rubygems'
require 'spork'
require 'json'
require 'coveralls'
Coveralls.wear!
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # To run simplecov
  # https://github.com/colszowka/simplecov/issues/42#issuecomment-4440284
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.formatter = Coveralls::SimpleCov::Formatter
    SimpleCov.start 'rails'
  end

  # Spork trap_method to delay route loading by devise
  # https://github.com/sporkrb/spork/wiki/Spork.trap_method-Jujitsu
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  # https://github.com/railsware/js-routes
  Spork.trap_method(JsRoutes, :generate!)
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'email_spec'
  require 'rspec/autorun'

  # Spork trap_methods to avoid reloading
  # https://github.com/sporkrb/spork/wiki/Spork.trap_method-Jujitsu
  # require 'rails/applicaion'
  # Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"
    
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end
    config.before(:each) do
      DatabaseCleaner.start
    end
    config.after(:each) do
      DatabaseCleaner.clean
    end

    # Picked it up from Ryan Bate's scrrencase on spork
    # http://railscasts.com/episodes/285-spork?view=asciicast
    # config.treat_symbols_as_metadata_keys_with_true_value = true
    config.filter_run focus: true
    config.run_all_when_everything_filtered = true

    # For Devise with factory girl
    # https://gist.github.com/pivotal-casebook/1073577
    config.include Devise::TestHelpers, type: :controller

    # For shoulda matchers
    require 'shoulda/matchers/integrations/rspec'
  end

end

Spork.each_run do
  # For simplecov
  # https://github.com/colszowka/simplecov/issues/42#issuecomment-4440284
  if ENV['DRB']
    require 'simplecov'
    SimpleCov.formatter = Coveralls::SimpleCov::Formatter
    SimpleCov.start 'rails'
  end
  # This code will be run each time you run your specs.
  FactoryGirl.reload
  # Watch out that with FactoryGirl is when specifying a class for a factory, using
  # a class constraint will cause the model to be preloaded in prefork preventing
  # reloading, whereas using a string will not
  # eg:
  # Factory.define :user, class: 'MyUserClass' do |f|
  #   ...
  # end

  I18n.backend.reload!

end

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.




