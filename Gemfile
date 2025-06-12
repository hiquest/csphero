source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 7.1.1"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 6.0"

# integrates with vite
gem "vite_rails"

# authentication and authorization
gem "devise", "~> 4.9"

# parses user agent data
gem "user_agent_parser", "~> 2.15"

group :development do
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
