# frozen_string_literal: true

class DestroyDocument
  def self.call(core:, id:)
    deleted = Db.delete(core, id)

    if deleted
      Cores.delete(core, id)

      Responder.message(200, "Document #{core}:#{id} deleted")
    else
      Responder.message(404, "Document #{core}:#{id} not found")
    end
  end
end
