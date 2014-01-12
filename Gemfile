require 'yaml'
source 'https://rubygems.org'
env = ENV["RAILS_ENV"] || "development"
dbconfig = File.expand_path("../config/database.yml", __FILE__)

raise "You need to configure config/database.yml first" unless File.exists?(dbconfig)
require 'erb'
config = YAML.load(ERB.new(File.read(dbconfig)).result)

environment = config[env]

adapter = environment["adapter"] if environement
raise "Please set an adpater in database.yml for #{env} environment" if adapter.nil?
case adapter
when "sqlite3"
  gem 'sqlite3'
when "postgresql"
  gem 'pg'
when "mysql2"
  gem 'mysql2'
else
  raise "Not supported database adapter: #{adapter}"
end

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'foundation-rails'
gem 'foundation-icons-sass-rails'
gem 'rolify', github: 'EppO/rolify'
gem 'therubyracer', :platform=>:ruby
gem 'thin'
gem 'simple_form'
gem 'aasm'
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'pry'
  gem 'guard-livereload'
end
group :development, :test do
  gem 'factory_girl_rails', '~>4.0'
  gem 'rspec-rails'
  gem 'faker'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'launchy'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
end
