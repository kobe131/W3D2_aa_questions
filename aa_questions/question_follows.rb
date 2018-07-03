require 'byebug'
require_relative 'questions_database'
require_relative 'question'
require_relative 'user'

class QuestionFollow
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows") 
    data.map { |datum| QuestionFollow.new(datum) }
  end
  
  def self.find_by_id(id)
    question_info = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
    *
    FROM
    question_follows
    WHERE
    id = ?
    SQL
    
    QuestionFollow.new(question_info.first) 
  end
  
  def self.followers_for_question_id(questions_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
    SELECT
    users_id
    FROM
    question_follows
    WHERE
    questions_id = ?
    SQL
    
    followers.map { |userid| User.find_by_id(userid.values) }
  end
  
  def self.followed_questions_for_user_id(user_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT 
    *
    FROM 
    questions 
    JOIN 
    question_follows ON 
    questions.id = question_follows.questions_id 
    WHERE 
    question_follows.users_id = ?
    SQL
    
    followers.map { |question| Question.new(question)}
  
  end 
  
  
  
  attr_accessor :users_id, :questions_id
  
  def initialize(options)
    @id = options['id']
    @users_id = options['users_id']
    @questions_id = options['questions_id']
  end
  
end
