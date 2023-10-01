class Request < ApplicationRecord
  belongs_to :customer
  has_many :request_details, dependent: :destroy

  enum pay_method: { credit_card: 0, transfer: 1 }
  enum requests_status: { waiting: 0, confirmation: 1, processing: 2, in_use: 3, cancel: 4 }

  validates :pay_method, presence: true
  validates :postage, presence: true
  validates :pay_money, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :address_name, presence: true

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + address_name
  end

  def address_no_name
  '〒' + postal_code + ' ' + address
  end

  def total
    pay_money - postage
  end

# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @question = Request.where("address_name LIKE?", "#{word}")
    elsif search == "partial_match"
      @question = Request.where("address_name LIKE?","%#{word}%")
    else
      @question = Request.all
    end
  end

end
