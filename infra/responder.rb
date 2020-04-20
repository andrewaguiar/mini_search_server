# frozen_string_literal: true

class Responder
  def self.create(status, result)
    [status, result]
  end

  def self.message(status, message)
    create(status, 'message' => message)
  end
end
