# frozen_string_literal: true

class GetInfo
  def self.call
    {
      cores: Cores.names,
      documents: Db.count_documents,
      version: '0.1.1'
    }
  end
end
