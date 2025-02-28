class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.string :address
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
