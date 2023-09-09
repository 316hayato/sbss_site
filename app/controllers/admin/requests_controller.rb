class Admin::RequestsController < ApplicationController
  def show
    @request = Request.find(params[:id])
    @request_details = @request.request_details
  end

  def update
    # ↓更新予定の申し込みデータを取得↓
    request = Request.find(params[:id])
    # ↓紐づいた申し込み内容データを取得↓
    request_detail = request.request_details
    # ↓申し込みステータスを更新↓
    request.update(request_params)
    # ↓申し込みステータスの値を検索↓
    requests_status_address = params[:request][:requests_status]
    # 申し込みステータスが「入金確認」だったら
    if requests_status_address == "1"
      # 申し込み内容データの各ステータスを「処理中」に更新
      request_detail.storage_status = "1"
      request_detail.sale_status = "1"
      request_detail.disposal_status = "1"
      request_detail.update
      redirect_to  request_path(request)
    # 申し込みステータスが「キャンセル」だったら
    elsif requests_status_address == "4"
      # 申し込み内容データの各ステータスを「利用停止」に更新
      request_detail.storage_status = "3"
      request_detail.sale_status = "3"
      request_detail.disposal_status = "3"
      request_detail.update
      redirect_to  request_path(request)
    else
      flash[:alert] = "情報の更新に失敗しました。"
      redirect_to  requests_path
    end
  end
  
  private

  def request_params
    params.require(:request).permit(:pay_method, :postal_code, :address, :address_name, :postage, :pay_money, :requests_status)
  end
end
