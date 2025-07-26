class CreateDatabaseVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :database_versions do |t|
      t.bigint :obj_id
      t.string   :obj_type
      t.json :obj_info
      t.string :event_type
      t.string :who_did_this
      t.timestamps
    end
  end
end
