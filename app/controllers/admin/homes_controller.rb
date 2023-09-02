class Admin::HomesController < ApplicationController
  def top
    @requests = Request.all
  end
end
