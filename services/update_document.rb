# frozen_string_literal: true

class UpdateDocument
  def self.call(core:, id:, content:)
    updated = Db.update(core, id, content)

    if updated
      Cores.persist(core, id, content)

      Responder.message(200, "Document #{core}:#{id} updated")
    else
      Responder.message(404, "Document #{core}:#{id} does not exist")
    end
  end
end
