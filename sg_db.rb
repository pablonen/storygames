require 'sqlite3'

class SGDB
  DB_NAME = "test.db".freeze

  def self.get_db
    SQLite3::Database.new "test.db"
  end

  def self.create_index
    db = self.get_db

    db.execute <<-SQL
      create table if not exists posts (
        post TEXT NOT NULL UNIQUE,
        id INTEGER PRIMARY KEY,
        topic INTEGER,
        FOREIGN KEY (topic) REFERENCES topics(id)
      );
    SQL

    db.execute <<-ZQL
      create table if not exists topics (
        topic TEXT NOT NULL UNIQUE,
        id INTEGER PRIMARY KEY
      );
    ZQL
  end

  def self.insert_topics(topics)
    marky = "(?)".freeze
    values_line = ([marky] * topics.length).join(',')
    insert_stmt_str = "insert or ignore into topics (topic) values #{values_line}"

    stmt = self.get_db.prepare(insert_stmt_str)
    stmt.execute topics
  end

  def self.insert_post(post, topic_id, db)
    insert_stmt_str = "insert or ignore into posts (post, topic) values (?,?)"
    stmt = db.prepare(insert_stmt_str)
    stmt.execute post, topic_id
  end

  def self.find_topic(topic)
    self.get_db.execute('select id from topics where topic = ?', topic)
  end
end
