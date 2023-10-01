class Public::QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def confirm
    @question = Question.new(question_params)
  end

  def create
    question = Question.new(question_params)
    question.customer_id = current_customer.id
    question.questions_solution = "回答をしてください"
    if question.save
      redirect_to thanx_questions_path
    else
      flash[:alert] = "登録に失敗しました。"
      render :new
    end
  end

  def thanx
  end

  def index
    @questions = current_customer.questions.all
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:questions_name, :questions_introduction)
  end
end
