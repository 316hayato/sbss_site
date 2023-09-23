class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
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
end
