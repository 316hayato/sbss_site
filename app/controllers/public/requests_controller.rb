class Public::RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def confirm
    #リスト内サービスの表示用変数
    @request_lists = current_customer.request_lists.all
    #合計金額用の変数
    total = 0
    #合計金額用のeachメゾット
    @request_lists.each do |request_lists|
      total += request_lists.subtotal
    end
    #合計金額用の変数
    @total_amount = total
    #送料800円の変数
    @postage = 800
    #支払金額用の変数
    @pay_money = @total_amount + @postage
    #ログインユーザーの住所
    @request = Request.new(request_params)
    @request.postal_code = current_customer.postal_code
    @request.address = current_customer.address
    @request.address_name = current_customer.last_name + current_customer.first_name
  end

  def create
    # 申し込み(request)モデルに注文を保存
    request = Request.new(request_params)
    request.customer_id = current_customer.id
    if request.save
    # 申し込み内容(RequestDetail)モデルに利用予定サービスの情報をもとに保存
      @request_lists = current_customer.request_lists
      @request_lists.each do |request_list|
        request_detail = RequestDetail.new
        request_detail.request_id = request.id
        request_detail.service_id = request_list.service_id
        request_detail.price = request_list.service.with_tax_price
        request_detail.amount = 30
        request_detail.save
      end
    # 利用予定サービスを全て削除
      current_customer.request_lists.destroy_all
    # 注文完了画面に遷移
      redirect_to thanx_requests_path
    else
      flash[:alert] = "申し込み失敗しました。"
      redirect_to request_lists_path
    end
  end

  def thanx
  end

  def index
    @requests = current_customer.requests.all
  end

  def show
    @request = Request.find(params[:id])
    @request_details = @request.request_details
  end

  private

  def request_params
    params.require(:request).permit(:pay_method, :postal_code, :address, :address_name, :postage, :pay_money)
  end
end
