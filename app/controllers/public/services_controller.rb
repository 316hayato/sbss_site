class Public::ServicesController < ApplicationController
  def index
    @services = Service.where(is_active: false)
  end

  def show
    @service = Service.find(params[:id])
    @request_list = RequestList.new
  end
end
