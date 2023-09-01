class Request < ApplicationRecord
  belongs_to :customer
  has_many :request_details, dependent: :destroy
  
  enum pay_method: { credit_card: 0, transfer: 1 }
  # enum status: { waiting: 0, confirmation: 1, production: 2, preparation: 3, completion: 4 }

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :address_name, presence: true
  validates :pay_method, presence: true
  validates :postage, presence: true
  validates :pay_money, presence: true

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + address_name
  end

  def total
    pay_money - postage
  end
end
