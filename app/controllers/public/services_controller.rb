class Public::ServicesController < ApplicationController
  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
    @request_list = RequestList.new
  end
end
