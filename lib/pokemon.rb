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
  
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?);
    SQL
    db.execute(sql, name, type)
  end
  
  def self.find(id, db)
    sql = <<-SQL
      SELECT * 
      FROM pokemon
      WHERE id = ?
    SQL
    pokemon_data = db.execute(sql, id).flatten
    Pokemon.new(id: pokemon_data[0], name: pokemon_data[1], type: pokemon_data[2], db: db)
    
  end
  
end
