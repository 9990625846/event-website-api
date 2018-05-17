source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'pg'
gem 'omniauth-facebook', '~> 4.0.0'
gem 'omniauth-google-oauth2'
# Use Puma as the app server
gem 'puma', '~> 3.7'

gem 'rack-cors', :require => 'rack/cors'
gem 'simple_token_authentication', '~> 1.0'

gem 'jbuilder', '~> 2.5'
gem 'devise'
gem "paperclip", "~> 5.0.0"
gem 'jwt'
gem 'rest-client'
# for newslatter
gem 'gibbon'
gem 'turbolinks', '~> 5'
gem 'coffee-rails', '~> 4.2'
gem 'uglifier', '>= 1.3.0'
gem 'sass-rails', '~> 5.0'
#gem 'active_model_serializers'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  # gem 'rspec'
   #gem 'factory_girl_rails'
   gem "factory_bot_rails"
   # or
	gem 'rspec-rails', '~> 3.5'
  # gem 'rspec-wait'
  # gem 'rspec-retry'
  # gem 'rspec-instafail'
  # gem 'rspec_junit_formatter'
	gem 'shoulda-matchers', '~> 3.0', require: false
  gem 'selenium-webdriver'

  #run automatically rspec
  gem "guard-rspec"

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', require: false
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner', '~> 1.5'
  gem 'shoulda-callback-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'jquery-validation-rails'
gem 'fog-local'