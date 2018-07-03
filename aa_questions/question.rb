
require 'byebug'
require_relative 'questions_database'
class Question 
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions") 
    data.map { |datum| Question.new(datum) }
  end
  
  def self.find_by_id(id)
    question_info = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
    *
    FROM
    questions
    WHERE
    id = ?
    SQL
    
    Question.new(question_info.first) 
  end
  
  def self.find_by_name(title)
    name = QuestionsDatabase.instance.execute(<<-SQL, title)
    SELECT
    *
    FROM
    questions
    WHERE
    title = ?
    SQL
    
    Question.new(name.first) 
  end
  
  attr_accessor :title, :body, :author_id 
  
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
  
end
