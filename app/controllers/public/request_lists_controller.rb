class Public::RequestListsController < ApplicationController
  def index
    @total_amount = 0
    @request_lists = RequestList.all
  end

  def create
    request_list = current_customer.request_lists.find_by(service_id: params[:request_list][:service_id])
    request_list = RequestList.new(request_list_params)
    request_list.customer_id = current_customer.id
    request_list.save
    flash[:notice] = "依頼サービスを追加しました。"
    redirect_to request_lists_path
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
      params.require(:request_list).permit(:service_id)
  end
end
