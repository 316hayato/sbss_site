class RequestList < ApplicationRecord
  belongs_to :service
  belongs_to :customer

  # 小計を求めるメソッド
  def subtotal
    service.with_tax_price
  end
end
