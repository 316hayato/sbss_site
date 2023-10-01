class Service < ApplicationRecord
  has_one_attached :image
  has_many :request_lists, dependent: :destroy
  has_many :request_details, dependent: :destroy

  validates :image, presence: true
  validates :service_name, presence: true
  validates :service_introduction, presence: true
  validates :price, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # 税込価格を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @service = Service.where("service_name LIKE?", "#{word}")
    elsif search == "partial_match"
      @service = Service.where("service_name LIKE?","%#{word}%")
    else
      @service = Service.all
    end
  end
end
