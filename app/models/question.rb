class Question < ApplicationRecord
  belongs_to :customer

  validates :questions_name, presence: true
  validates :questions_introduction, presence: true
  validates :questions_solution, presence: true

# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @question = Question.where("questions_name LIKE?", "#{word}")
    elsif search == "partial_match"
      @question = Question.where("questions_name LIKE?","%#{word}%")
    else
      @question = Question.all
    end
  end

# 絞り込み機能
  def self.sorts(search, word)
    if search == "id"
      @question = Question.where("id LIKE?","%#{word}%")
    elsif search == "name"
      @question = Question.where("questions_name LIKE?","%#{word}%")
    else
      @question = Question.all
    end
  end
end
