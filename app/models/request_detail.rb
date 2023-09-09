class RequestDetail < ApplicationRecord
  belongs_to :request
  belongs_to :service

  enum storage_status: { storage_not_use: 0, storage_working: 1, storage_completion: 2, storage_cancel: 3 }
  enum sale_status: { sale_not_use: 0, sale_working: 1, sale_completion: 2, sale_cancel: 3 }
  enum disposal_status: { disposal_not_use: 0, disposal_working: 1, disposal_completion: 2, disposal_cancel: 3 }

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
