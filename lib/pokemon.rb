require 'pry'

class Pokemon
  
  attr_accessor :name, :type, :db
  attr_reader :id
  
  def initialize(id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end
  
  def save
    sql = <<-SQL
      INSERT INTO pokemon (name, type, db)
      VALUES (?, ?, ?)
    SQL
    binding.pry
    DB[:conn].execute(sql, self.name, self.type, self.db)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  # def self.create_table
  #   sql = <<-SQL
  #     CREATE TABLE IF NOT EXISTS pokemons (
  #     id INTEGER PRIMARY KEY,
  #     name TEXT,
  #     type TEXT
  #     )
  #   SQL
  #   DB[:conn].execute(sql)
  # end
  
  def self.find(id)
    sql = <<-SQL
      SELECT * 
      FROM pokemons
      WHERE id = ?
    SQL
    DB[:conn].execute(sql, id)
    
  end
  
end
