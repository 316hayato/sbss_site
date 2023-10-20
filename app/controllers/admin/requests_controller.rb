class Admin::RequestsController < ApplicationController
  def show
    @request = Request.find(params[:id])
    @request_details = @request.request_details.all
  end

  def update
    # ↓更新予定の申し込みデータを取得↓
    request = Request.find(params[:id])
    # ↓紐づいた申し込み内容データを取得↓
    request_details = RequestDetail.where(request_id: params[:id])
    # ↓申し込みステータスを更新↓
    if request.update(request_params)
      if request.requests_status == "waiting" # 申し込みステータスが「入金待ち」だったら
        request_details.update(storage_status: 0, sale_status: 0, disposal_status: 0)
      elsif request.requests_status == "confirmation" # 申し込みステータスが「入金確認」だったら
        request_details.update(storage_status: 1, sale_status: 1, disposal_status: 1)
      elsif request.requests_status == "in_use" # 申し込みステータスが「サービス利用中」だったら
        request_details.update(storage_status: 2, sale_status: 2, disposal_status: 2)
      elsif request.requests_status == "cancel" # 申し込みステータスが「キャンセル」だったら
        request_details.update(storage_status: 3, sale_status: 3, disposal_status: 3)
      else
        flash[:alert] = "ステータスの更新に失敗しました。"
      end
      flash[:alert] = "ステータスを更新しました。"
    else
      flash[:alert] = "情報の更新に失敗しました。"
    end
    redirect_to  admin_request_path(request)
  end

  private

  def request_params
    params.require(:request).permit(:requests_status)
  end
end
