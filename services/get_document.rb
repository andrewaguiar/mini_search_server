# frozen_string_literal: true

class GetDocument
  def self.call(core:, id:)
    return Responder.message(404, "Core #{core} does not exist") unless Cores.exists?(core)

    result = Db.get(core, id)

    if result
      document = {
        id: result['external_id'],
        content: result['content']
      }

      Responder.create(200, document)
    else
      Responder.message(404, "Document #{core}:#{id} not found")
    end
  end
end
