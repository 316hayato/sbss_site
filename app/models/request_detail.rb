class RequestDetail < ApplicationRecord
  belongs_to :request
  belongs_to :service

  def subtotal
    service.with_tax_price * amount
  end

  def total
    # 繰り返し計算する処理を記述する
    result = 0
    request.request_details.each do |n|
      result += n.amount
    end
    result
  end
end
