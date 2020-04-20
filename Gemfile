# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'activesupport', require: %w[active_support/dependencies]
gem 'mini_search'
gem 'oj'
gem 'pg'
gem 'sinatra'
gem 'sinatra-reloader'

group :production do
  gem 'passenger'
end

group :development, :test do
  gem 'dotenv'
  gem 'rubocop', require: false
  gem 'thin'
end
