# frozen_string_literal: true

require './infra/banner'

puts Banner.show

require 'sinatra'

if development?
  require 'dotenv/load'
  require 'sinatra/reloader'
end

require 'sinatra/streaming'

require './bootstrap.rb'
require './configuration.rb'
require './authentication.rb'
require './sinatra_responder.rb'
require './routes.rb'
