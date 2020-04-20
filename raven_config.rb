# frozen_string_literal: true

Raven.configure do |config|
  config.current_environment = 'production'
  config.dsn = ENV['SENTRY_DSN']
end
