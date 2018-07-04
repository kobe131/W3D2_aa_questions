require 'byebug'
require_relative 'questions_database'
require_relative 'question'
require_relative 'user'
class QuestionLike
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes") 
    data.map { |datum| QuestionLike.new(datum) }
  end
  
  def self.find_by_id(id)
    question_like_info = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
    *
    FROM
    question_likes
    WHERE
    id = ?
    SQL
    
    QuestionLike.new(question_like_info.first) 
  end
  
  def self.most_liked_questions(n)
    question_liked = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
    *
    FROM
    questions
    JOIN question_likes ON 
    questions.id = question_likes.questions_id 
    GROUP BY questions_id
    ORDER BY COUNT(*) 
    LIMIT ?
    
    SQL
    question_liked.map { |question| Question.new(question)}
  end
  
  attr_accessor :users_id, :questions_id
  
  def initialize(options)
    @id = options['id']
    @users_id = options['users_id']
    @questions_id = options['questions_id']
  end
  
end
