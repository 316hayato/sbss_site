class CreateRequestLists < ActiveRecord::Migration[6.1]
  def change
    create_table :request_lists do |t|
      t.integer :service_id,      null: false
      t.integer :customer_id,     null: false
      t.integer :amount,          null: false
      t.timestamps
    end
  end
end
