class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Customer"
      @customers = Customer.looks(params[:search], params[:word])
      @title = "会員一覧"
      @count = @customers.count
    elsif @range == "Question"
      @questions = Question.looks(params[:search], params[:word])
      @title = "お問い合わせ一覧"
      @count = @questions.count
    elsif @range == "Request"
      @requests = Request.looks(params[:search], params[:word])
      @title = "依頼履歴一覧"
      @count = @requests.count
    elsif @range == "Service"
      @services = Service.looks(params[:search], params[:word])
      @title = "サービス一覧"
      @count = @services.count
    else
      redirect_to admin_root_path
    end
    render "/admin/searches/search_result"
  end
end
