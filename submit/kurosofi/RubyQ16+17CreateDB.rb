require 'sqlite3'
db = SQLite3::Database.new("RubyQ16_17.db")

sql = <<SQL
CREATE TABLE newsBook (
  id integer PRIMARY KEY AUTOINCREMENT,
  title text NOT NULL,
  url text NOT NULL UNIQUE,
  addres text NOT NULL,
  time text NOT NULL,
  get_time integer
);
SQL

db.execute(sql)
db.close