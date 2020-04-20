# frozen_string_literal: true

before do
  if ENV['AUTH_TOKEN']
    halt 500 unless request.env['HTTP_AUTHTOKEN'] == ENV['AUTH_TOKEN']
  end
end
