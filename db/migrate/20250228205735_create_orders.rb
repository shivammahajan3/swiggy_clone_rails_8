class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.time :order_time
      t.float :total_price
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :restro, null: false, foreign_key: true

      t.timestamps
    end
  end
end
