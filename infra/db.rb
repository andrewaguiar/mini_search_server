# frozen_string_literal: true

class Db
  require 'pg'

  def self.init
    puts "DB :: Creating #{document_table_name} table"

    conn.exec(
      "CREATE TABLE IF NOT EXISTS #{document_table_name} (" \
      '  id serial NOT NULL PRIMARY KEY,' \
      '  external_id integer NOT NULL,' \
      '  core varchar(100) NOT NULL,' \
      '  content text NOT NULL' \
      ')'
    )

    conn.exec(
      "CREATE UNIQUE INDEX IF NOT EXISTS core_external_id ON #{document_table_name} (core, external_id)"
    )
  end

  def self.all_documents
    conn.exec(
      "SELECT core, external_id, content FROM #{document_table_name}"
    )
  end

  def self.count_documents
    result = conn.exec(
      "SELECT count(id) AS c FROM #{document_table_name}"
    )

    result.getvalue(0,0)
  end

  def self.get(core, id)
    result = conn.exec_params(
      "SELECT external_id, core, content FROM #{document_table_name} WHERE core = $1 AND external_id = $2",
      [core, id]
    )

    result.cmd_tuples == 1 ? result[0] : nil
  end

  def self.persist(core, id, content)
    result = conn.exec_params(
      "INSERT INTO #{document_table_name}(core, external_id, content) VALUES ($1, $2, $3)",
      [core, id, content]
    )

    result.cmd_tuples == 1
  rescue StandardError => e
    raise e unless e.message =~ /duplicate key value violates unique constraint/

    false
  end

  def self.update(core, id, content)
    result = conn.exec_params(
      "UPDATE #{document_table_name} SET content = $1 WHERE core = $2 AND external_id = $3",
      [content, core, id]
    )

    result.cmd_tuples == 1
  rescue StandardError => e
    raise e unless e.message =~ /duplicate key value violates unique constraint/

    false
  end

  def self.delete(core, id)
    result = conn.exec_params(
      "DELETE FROM #{document_table_name} WHERE core = $1 AND external_id = $2",
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

  private_class_method def self.document_table_name
    ENV['DOCUMENT_TABLE_NAME'] || 'documents'
  end
end
