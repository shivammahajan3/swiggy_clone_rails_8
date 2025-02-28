class CreateRestros < ActiveRecord::Migration[8.0]
  def change
    create_table :restros do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
