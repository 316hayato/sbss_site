class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :customer_id,     null: false
      t.integer :pay_method,      null: false, default: 0
      t.integer :postage,         null: false
      t.integer :pay_money,       null: false
      t.integer :requests_status, null: false, default: 0
      t.timestamps
    end
  end
end
