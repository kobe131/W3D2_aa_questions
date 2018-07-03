
require 'byebug'
require_relative 'questions_database'
require_relative 'reply'
class User
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
     
    data.map { |datum| User.new(datum) }
  end
  
  def self.find_by_id(id)
    user_info = QuestionsDatabase.instance.execute(<<-SQL, id)
    
    SELECT
    *
    FROM
    users
    WHERE
    id = ?
    SQL
    
    User.new(user_info.first) 
  end
  
  def self.find_by_name(fname,lname)
    name = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
    *
    FROM
    users
    WHERE
    fname = ? AND lname = ?
    SQL
    
    User.new(name.first) 
  end
  
  def authored_replies
    Reply.find_by_id(@id)
  end
  
  attr_accessor :fname, :lastname, :id 
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
end
