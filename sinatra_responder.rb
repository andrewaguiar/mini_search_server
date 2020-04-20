# frozen_string_literal: true

def respond(sinatra, result)
  status, result = result

  sinatra.status(status)
  Oj.dump(result)
end
