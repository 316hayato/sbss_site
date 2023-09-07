class Admin::ServicesController < ApplicationController
  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    service = Service.new(service_params)
    if service.save
      flash[:notice] = "登録に成功しました。"
      redirect_to admin_service_path(service)
    else
      flash[:alert] = "登録に失敗しました。"
      render :new
    end
  end

  def show
    @service = Service.find(params[:id])
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to admin_service_path(@service)
    else
      flash[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  private

  def service_params
    params.require(:service).permit(:image, :service_name, :service_introduction, :price, :is_active)
  end
end
