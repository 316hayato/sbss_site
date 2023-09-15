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
    if question.save
      flash[:notice] = "登録に成功しました。"
      redirect_to thanx_questions_path
    else
      flash[:alert] = "登録に失敗しました。"
      render :new
    end
  end

  def thanx
  end

  private

  def question_params
    params.require(:question).permit(:questions_name, :questions_introduction)
  end
end
