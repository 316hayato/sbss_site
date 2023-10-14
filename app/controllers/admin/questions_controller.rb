class Admin::QuestionsController < ApplicationController
  def index
    @questions = Question.sorts(params[:search], params[:word])
    # @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to admin_question_path(@question)
    else
      flash[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  private

  def question_params
    params.require(:question).permit(:questions_solution, :is_answer)
  end
end
