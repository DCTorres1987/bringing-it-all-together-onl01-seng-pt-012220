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
  
end