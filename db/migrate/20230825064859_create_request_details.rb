class CreateRequestDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :request_details do |t|
      t.integer :request_id,      null: false
      t.integer :service_id,      null: false
      t.integer :price,           null: false
      t.integer :amount,          null: false
      t.integer :storage_status,  null: false, default: 0
      t.integer :sale_status,     null: false, default: 0
      t.integer :disposal_status, null: false, default: 0
      t.timestamps
    end
  end
end
