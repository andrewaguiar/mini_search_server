# frozen_string_literal: true

class RescueErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue StandardError => e
    query_hash = env['rack.request.query_hash'] || {}
    form_hash = env['rack.request.form_hash'] || {}

    Raven.extra_context(query_hash.merge(form_hash))
    Raven.capture_exception(e)

    raise e
  end
end
