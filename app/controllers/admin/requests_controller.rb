class Admin::RequestsController < ApplicationController
  def show
    @request = Request.find(params[:id])
    @request_details = @request.request_details
  end

  def update

  end
end
