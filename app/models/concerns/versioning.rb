# == Schema Information
# Table name: database_versions
#  obj_id          :integer
#  obj_type        :string
#  obj_info        :json         
#  event_type      :string
#  who_did_this    :string
#  created_at      :datetime           
#  updated_at      :datetime

module Versioning
  extend ActiveSupport::Concern

  included do
    after_create :create_version
    after_update :update_version
    after_destroy :destroy_version

    def previous_version_info
      version = DatabaseVersion.where(obj_id: id).order(created_at: :desc).first
      version&.obj_info || {}
    end

    def switch_to_previous_version
      previous_version = self.previous_version_info
      previous_version.each{ |key, value| self.send("#{key}=", value.first) }
      self.save
    end
  end

  def create_version
    DatabaseVersion.create(obj_id: id, obj_type: self.class.name, event_type: "Create",
                            obj_info: attributes, who_did_this: "admin" )
  end

  def update_version
     DatabaseVersion.create(obj_id: id, obj_type: self.class.name, event_type: "Update",
                            obj_info: saved_changes, who_did_this: "admin" )
  end

  def destroy_version
     DatabaseVersion.create(obj_id: id, obj_type: self.class.name, event_type: "Destroy",
                            obj_info: attributes, who_did_this: "admin" )
  end

end

