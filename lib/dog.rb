require 'pry'

class Dog 
  
  attr_accessor :name, :breed, :id 
  
  def initialize(attributes)
    #id: nil, name:, breed:
    attributes.each {|key, value| self.send(("#{key}="), value)}
    self.id ||= nil
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
    attributes_hash = {
      :id => row[0],
      :name => row[1],
      :breed => row[2]
    }
    self.new(attributes_hash)
  end
  
  def self.find_by_id(id)
    sql = <<-SQL
      SELECT * FROM dogs WHERE id = ?
    SQL
    
    DB[:conn].execute(sql, id).map do |row|
      self.new_from_db(row)
    end.first
  end
  
  def self.find_or_create_by(name:, breed:)
    dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed)
    if !dog.empty?
      song_data = song[0]
      song = Song.new(song_data[0], song_data[1], song_data[2])
    else
      song = self.create(name: name, breed: breed)
    end
    song
  end
  
end