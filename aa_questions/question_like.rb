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
  
  attr_accessor :users_id, :questions_id
  
  def initialize(options)
    @id = options['id']
    @users_id = options['users_id']
    @questions_id = options['questions_id']
  end
  
end
