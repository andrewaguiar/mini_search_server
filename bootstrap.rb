# frozen_string_literal: true

require 'base64'
require 'dotenv'
require 'net/http'
require 'oj'
require 'open3'
require 'open-uri'
require 'phashion'
require 'rmagick'
require 'securerandom'
require 'tempfile'

Bundler.setup :default, Sinatra::Application.environment
Bundler.require

# Set autoloading directories
ActiveSupport::Dependencies.autoload_paths += %w[infra middlewares services]


Dotenv.load

Db.init
Cores.init
