# frozen_string_literal: true

class Cores
  def self.init
    puts 'Cores :: initializing'

    i = 0

    Db.all_documents.each do |document|
      persist(
        document['core'],
        document['external_id'],
        document['content']
      )

      i += 1
    end

    puts "Cores :: initialized with #{i} documents and #{keys.size} cores"
  end

  def self.persist(core, id, content)
    get_core(core).index(id: id, indexed_field: content)
  end

  def self.delete(core, id)
    get_core(core).remove(id)
  end

  def self.search(core, terms)
    get_core(core).search(terms)
  end

  def self.exists?(core)
    !cores[core].nil?
  end

  private_class_method def self.get_core(core)
    cores[core] = MiniSearch.new_localized_index(ENV['DEFAULT_CORE_LANG'].to_sym) unless exists?(core)
    cores[core]
  end

  private_class_method def self.keys
    cores.keys
  end

  private_class_method def self.cores
    # rubocop:disable Style/GlobalVars
    $cores ||= {}
    $cores
    # rubocop:enable Style/GlobalVars
  end
end
