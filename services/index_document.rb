# frozen_string_literal: true

class IndexDocument
  def self.call(core:, id:, content:)
    persisted = Db.persist(core, id, content)

    if persisted
      Cores.persist(core, id, content)

      Responder.message(201, "Document #{core}:#{id} created")
    else
      Responder.message(400, "Document #{core}:#{id} already exists")
    end
  end
end
