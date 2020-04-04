require 'pry'

class Dog 
  
  attr_accessor :name, :breed, :id 
  
  def initialize(hash)
    @name = hash[:name]
    @breed = hash[:breed]
  end
  
end