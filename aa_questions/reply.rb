
require 'byebug'
require_relative 'questions_database'
require_relative 'question'
require_relative 'user'

class Reply
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies") 
    data.map { |datum| Reply.new(datum) }
  end
  
  def self.find_by_id(id)
    reply_info = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
    *
    FROM
    replies
    WHERE
    id = ?
    SQL
    
    Reply.new(reply_info.first) 
  end
  
  def parent_reply
    Reply.find_by_id(@parents_reply_id)
  end 
  
  def child_replies
    child_reps = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
    *
    FROM
    replies 
    WHERE
    parents_reply_id = ?
    SQL
    
    child_reps.map {|child| Reply.new(child)}

 
  end 
  
  
  attr_accessor :id, :body, :questions_id, :parents_reply_id, :users_id 
  
  def initialize(options)
    @id = options['id']
    @questions_id = options['questions_id']
    @parents_reply_id = options['parents_reply_id']
    @users_id = options['users_id']
  end
  
end
