class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    # 検索対象が「サービス」のみの場合
    @range = "Service"
    @word = params[:word]

    @services = Service.looks("partial_match", params[:word])
    @title = "サービス一覧"
    @count = @services.count
    render "/public/searches/search_result"

=begin
    # 検索対象が複数ある場合(将来対応)
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
=end

  end
end
