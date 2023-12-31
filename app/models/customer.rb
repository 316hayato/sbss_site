class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# ゲストログイン用メゾット
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "------"
      user.first_name = "------"
      user.last_name_kana = "------"
      user.first_name_kana = "------"
      user.postal_code = "------------"
      user.address = "------------"
      user.telephone_number = "------------"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

  has_many :requests, dependent: :destroy
  has_many :request_lists, dependent: :destroy
  has_many :questions

# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("last_name LIKE? or first_name LIKE ? or last_name_kana LIKE ? or first_name_kana LIKE?", "#{word}","#{word}","#{word}","#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("last_name LIKE? or first_name LIKE ? or last_name_kana LIKE ? or first_name_kana LIKE?", "%#{word}%","%#{word}%","%#{word}%","%#{word}%")
    else
      @customer = Customer.all
    end
  end

# 絞り込み機能
  def self.sorts(search, word)
    if search == "id"
      @customer = Customer.where("id LIKE?", "%#{word}%")
    elsif search == "name"
      @customer = Customer.where("last_name LIKE? or first_name LIKE ?", "%#{word}%","%#{word}%")
    elsif search == "email"
      @customer = Customer.where("email LIKE?", "%#{word}%")
    else
      @customer = Customer.all
    end
  end

end
