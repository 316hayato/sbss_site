class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Service"
      @services = Service.looks(params[:search], params[:word])
      @title = "サービス一覧"
      @count = @services.count
    else
      redirect_to root_path
    end
    render "/public/searches/search_result"
  end
end
