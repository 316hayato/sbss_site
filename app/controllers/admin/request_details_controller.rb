class Admin::RequestDetailsController < ApplicationController
  def update
    # 申し込み内容データを取得
    request_detail = RequestDetail.find(params[:id])
    # 申し込み内容に紐づく申し込みデータを取得
    request = Request.find(params[:request_id])
    # ステータスを更新
    request_detail.update(request_detail_params)
    # 申し込みに紐づく申し込み内容の各ステータス
    storage_status_address = params[:request_detail][:storage_status].to_i         # 保存ステータス
    sale_status_address = params[:request_detail][:sale_status].to_i         # 売却ステータス
    disposal_status_address = params[:request_detail][:disposal_status].to_i # 処理ステータス
    # 複数のステータスが「完了」している場合
    if  (storage_status_address == "2" && sale_status_address == "2") || (storage_status_address == "2" && disposal_status_address == "2") || 
      (sale_status_address == "2" && disposal_status_address == "2") || (storage_status_address == "2" && sale_status_address == "2" && disposal_status_address == "2")
      # 申し込みステータスを「複数サービス利用済み」に#更新
      request.requests_status = "3" 
      request.update 
    # 各ステータスの1つが「完了」している場合
    elsif storage_status_address == "2" || sale_status_address == "2" || disposal_status_address == "2"
      # 申し込みステータスを「サービス利用済み」に更新
      request.requests_status = "2" 
      request.update 
    else
      flash[:alert] = "情報の更新に失敗しました。"
    end
    redirect_to  admin_request_path(request)
  end
  
  private
  
  def request_detail_params
    params.require(:request_detail).permit(:save_status, :sale_status, :disposal_status)
  end
  
end
