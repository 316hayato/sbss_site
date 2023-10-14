class Admin::HomesController < ApplicationController
  def top
    @requests = Request.sorts(params[:search], params[:word])
    # @requests = Request.all
  end
end
