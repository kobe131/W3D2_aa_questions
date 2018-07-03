require 'sqlite3'
require 'singleton'
class QuestionsDatabse < SQLite3::Databse 
  include Singleton 
  def initalize
    super('questions.db')
    self.type_translation = true 
    self.results_as_hash = true 
  end 
end 

class Users
  attr_accessor :fname, :lastname 
  def self.all
   data = PlayDBConnection.instance.execute("SELECT * FROM users")
   data.map { |datum| Play.new(datum) }
 end 
end
