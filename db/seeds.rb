# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

# 管理者ログイン
Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "#{ENV['SECRET_KEY']}"
end

# ゲストログイン
Customer.find_or_create_by!(email: 'guest@example.com') do |user|
  user.password = SecureRandom.urlsafe_base64
  user.last_name = "ゲスト"
  user.first_name = "ユーザー"
  user.last_name_kana = " "
  user.first_name_kana = " "
  user.postal_code = " "
  user.address = " "
  user.telephone_number = " "
end

# テストログイン
Customer.find_or_create_by!(email: 'test@example.com') do |user|
  user.password = "12345"
  user.last_name = "テスト"
  user.first_name = "ユーザー"
  user.last_name_kana = " "
  user.first_name_kana = " "
  user.postal_code = " "
  user.address = " "
  user.telephone_number = " "
end

# 初期サービス(デフォルト)
Service.find_or_create_by!(service_name: "保管サービス") do |service|
  service.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/save_service.jpg"), filename:"save_service.jpg")
  service.service_introduction = "住居スペースが確保できない方におススメのサービスになります。"
  service.price = 1500
  service.is_active = false
end

Service.find_or_create_by!(service_name: "売却サービス") do |service|
  service.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sale_service.jpg"), filename:"sale_service.jpg")
  service.service_introduction = "不要になった本の売却を承るサービスになります。"
  service.price = 1500
  service.is_active = false
end

Service.find_or_create_by!(service_name: "処分サービス") do |service|
  service.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/disposal_service.jpg"), filename:"disposal_service.jpg")
  service.service_introduction = "不要な本の処分を検討している方におススメのサービスになります。",
  service.price = 1500
  service.is_active = false
end

puts "seedの実行が完了しました"