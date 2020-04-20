# frozen_string_literal: true

class SearchDocument
  def self.call(core:, terms:)
    return Responder.message(404, "Core #{core} does not exist") unless Cores.exists?(core)

    Responder.create(200, Cores.search(core, terms))
  end
end
