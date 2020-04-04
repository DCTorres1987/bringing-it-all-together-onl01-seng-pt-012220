require 'pry'

class Dog 
  
  attr_accessor :name, :breed, :id 
  
  def initialize(hash)
    @id = nil
    @name = hash[:name]
    @breed = hash[:breed]
  end
  
  def self.create_table
    
    DB[:conn].execute("DROP TABLE IF EXISTS dogs")
    
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
        SQL
    DB[:conn].execute(sql)

  end
  
  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS dogs")
  end
  
  def update
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

  def save
   
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      
      self
  end
  
  def self.create(hash)
      dog = self.new(hash)
      dog.save
      dog
  end
  
  def self.new_from_db(row)
    id = nil
    name = row[:name]
    breed = row[:breed]
    self.new(id, name, breed)
  end 
  
end