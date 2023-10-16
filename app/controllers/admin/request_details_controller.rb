class Admin::RequestDetailsController < ApplicationController
  def update
    # 申し込み内容データを取得
    request = Request.find(params[:request_detail][:request_id])
    # ↓紐づいた申し込み内容データを取得↓
    request_detail = RequestDetail.find(params[:id])
    # 申し込みに紐づく申し込み内容の各ステータス
    # [保存ステータス] = request_detail.storage_status
    # [売却ステータス] = request_detail.sale_status
    # [処理ステータス] = request_detail.disposal_status
    # 各ステータスを更新↓
    if request_detail.update(request_detail_params)
      # 以下ステータスの連動更新(=begin～=end)は将来対応
=begin
      # [サービスID] = request_detail.service_id
      if request_detail.service_id = 1 # 申込内容が「保管サービス」
        # 保存ステータスが「業者受取中」の場合
        if request_detail.storage_status == "storage_working"
          #申し込みステータスを「業者対応中」に更新する
          if request.requests_status != 2
            request.update(requests_status: 2)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        # 保存ステータスが「保管完了」の場合
        elsif request_detail.storage_status == "storage_completion"
          #申し込みステータスを「サービス利用中」に更新する
          if request.requests_status != 3
            request.update(requests_status: 3)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        # 保存ステータスが「保管キャンセル」の場合
        elsif request_detail.storage_status == "storage_cancel"
          #申し込みステータスを「キャンセル」に更新する
          if request.requests_status != 4
            request.update(requests_status: 4)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        else
          flash[:alert] = "不正なステータスが入力されました。"
        end
      elsif request_detail.service_id = 2 # 申込内容が「売却サービス」
        # 売却ステータスが「売却処理中」の場合
        if request_detail.sale_status == "sale_working"
          #申し込みステータスを「業者対応中」に更新する
          if request.requests_status != 2
            request.update(requests_status: 2)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        # 売却ステータスが「売却完了」の場合
        elsif request_detail.sale_status == "sale_completion"
          #申し込みステータスを「サービス利用中」に更新する
          if request.requests_status != 3
            request.update(requests_status: 3)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        # 売却ステータスが「売却キャンセル」の場合
        elsif request_detail.sale_status == "sale_cancel"
          #申し込みステータスを「キャンセル」に更新する
          if request.requests_status != 4
            request.update(requests_status: 4)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        else
          flash[:alert] = "不正なステータスが入力されました。"
        end
      elsif request_detail.service_id = 3 # 申込内容が「処分サービス」
         # 処分ステータスが「処分処理中」の場合
        if request_detail.disposal_status == "disposal_working"
          #申し込みステータスを「業者対応中」に更新する
          if request.requests_status != 2
            request.update(requests_status: 2)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        # 処分ステータスが「処分完了」の場合
        elsif request_detail.disposal_status == "disposal_completion"
          #申し込みステータスを「サービス利用中」に更新する
          if request.requests_status != 3
            request.update(requests_status: 3)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        # 処分ステータスが「処分キャンセル」の場合
        elsif request_detail.disposal_status == "disposal_cancel"
          #申し込みステータスを「キャンセル」に更新する
          if request.requests_status != 4
            request.update(requests_status: 4)
          else
            flash[:alert] = "最新の申し込みステータスです。"
          end
        else
          flash[:alert] = "不正なステータスが入力されました。"
        end
      else
        flash[:alert] = "適応外のサービスが入力されました。"
      end
=end
    else
      flash[:alert] = "情報の更新に失敗しました。"
    end
    redirect_to  admin_request_path(request)
  end

  private

  def request_detail_params
    params.require(:request_detail).permit(:service_id, :storage_status, :sale_status, :disposal_status)
  end

end
