# frozen_string_literal: true

class Db
  require 'pg'

  def self.init
    puts 'DB :: Creating documents table'

    conn.exec(
      'CREATE TABLE IF NOT EXISTS documents (' \
      '  id serial NOT NULL PRIMARY KEY,' \
      '  external_id integer NOT NULL,' \
      '  core varchar(100) NOT NULL,' \
      '  content text NOT NULL' \
      ')'
    )

    conn.exec(
      'CREATE UNIQUE INDEX IF NOT EXISTS core_external_id ON documents (core, external_id)'
    )
  end

  def self.all_documents
    conn.exec('SELECT core, external_id, content FROM documents')
  end

  def self.count_documents
    conn.exec('SELECT count(id) AS c FROM documents')[0]['c']
  end

  def self.get(core, id)
    result = conn.exec_params(
      'SELECT external_id, core, content FROM documents WHERE core = $1 AND external_id = $2',
      [core, id]
    )

    result.cmd_tuples == 1 ? result[0] : nil
  end

  def self.persist(core, id, content)
    conn.exec_params(
      'INSERT INTO documents(core, external_id, content) VALUES ($1, $2, $3)',
      [core, id, content]
    )

    true
  rescue StandardError => e
    raise e unless e.message =~ /duplicate key value violates unique constraint/

    false
  end

  def self.delete(core, id)
    result = conn.exec_params(
      'DELETE FROM documents WHERE core = $1 AND external_id = $2',
      [core, id]
    )

    result.cmd_tuples == 1
  end

  private_class_method def self.conn
    @conn ||= create_conn
  end

  private_class_method def self.create_conn
    uri = URI.parse(ENV['DATABASE_URL'])

    PG.connect(
      uri.hostname,
      uri.port,
      nil,
      nil,
      uri.path[1..-1],
      uri.user,
      uri.password
    )
  end
end
