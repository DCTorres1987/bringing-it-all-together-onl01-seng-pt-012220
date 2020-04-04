require 'pry'

class Dog 
  
  attr_accessor :name, :breed, :id 
  
  def initialize(hash)
    @id = nil
    @name = hash[:name]
    @breed = hash[:breed]
  end
  
  def self.create_table
    
  end
  
end