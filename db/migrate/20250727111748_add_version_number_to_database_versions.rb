class AddVersionNumberToDatabaseVersions < ActiveRecord::Migration[8.0]
  def change
    add_column :database_versions, :version_number, :integer
  end
end
