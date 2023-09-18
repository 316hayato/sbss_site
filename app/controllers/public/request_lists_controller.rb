class Public::RequestListsController < ApplicationController
  def index
    @request_lists = RequestList.all
    total = 0
    #合計金額用のeachメゾット
    @request_lists.each do |request_lists|
      total += request_lists.subtotal
    end
    #合計金額用の変数
    @total_amount = total
  end

  def create
    request_list = current_customer.request_lists.find_by(service_id: params[:request_list][:service_id])
    request_list = RequestList.new(request_list_params)
    request_list.customer_id = current_customer.id
    request_list.save
    flash[:notice] = "依頼サービスを追加しました。"
    redirect_to request_lists_path
  end

  def update
    request_list = RequestList.find(params[:id])
    if request_list.update(request_list_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to request_lists_path
    else
      flash[:alert] = "更新に失敗しました。"
      redirect_to request_lists_path
    end
  end

  def destroy_all
    current_customer.request_lists.destroy_all
    redirect_to request_lists_path
  end

  def destroy
    request_list = RequestList.find(params[:id])
    request_list.destroy
    redirect_to request_lists_path
  end

  private

  def request_list_params
      params.require(:request_list).permit(:service_id, :amount)
  end
end
