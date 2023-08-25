class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :customer_id,             null: false
      t.string  :questions_name,          null: false
      t.text    :questions_introduction,  null: false
      t.timestamps
    end
  end
end
