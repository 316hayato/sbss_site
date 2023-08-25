class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string  :service_name,          null: false
      t.text    :service_introduction,  null: false
      t.integer :price,                 null: false
      t.boolean :is_active,             null: false, default: true
      t.timestamps
    end
  end
end
