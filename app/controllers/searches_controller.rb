class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "Customer"
      @customers = Customer.looks(params[:search], params[:word])
      render "/searches/search_result"
    elsif @range == "Question"
      @questions = Question.looks(params[:search], params[:word])
      render "/searches/search_result"
    else
      @services = Service.looks(params[:search], params[:word])
      render "/searches/search_result"
    end
  end
end
