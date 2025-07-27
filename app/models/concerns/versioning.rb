# == Schema Information
# Table name: database_versions
#  obj_id         :integer
#  obj_type       :string
#  obj_info       :json         
#  event_type     :string
#  who_did_this   :string
#  version_number :integer

module Versioning
  extend ActiveSupport::Concern

  included do
    after_create  :create_version
    after_update  :update_version
    after_destroy :destroy_version

    def version_info(ver_num)
      version = DatabaseVersion.find_by(obj_id: id, obj_type: self.class.name, version_number: ver_num)
      version&.obj_info || {}
    end

    def switch_to_version(ver_num)
      version = DatabaseVersion.find_by(obj_id: id, obj_type: self.class.name, version_number: ver_num)
      return unless version
      version.obj_info.each{|key, value| self.send("#{key}=", value.is_a?(Array) ? value.first : value) }
      self.save if self.changed?
    end
  end

  private

  def create_version
    store_version("Create", attributes)
  end

  def update_version
    store_version("Update", saved_changes)
  end

  def destroy_version
    store_version("Destroy", attributes)
  end

  def store_version(event_type, data)
    DatabaseVersion.create(obj_id: id, obj_type: self.class.name, event_type: event_type, obj_info: data, who_did_this: current_user.username || "System", version_number: get_version_number + 1 )
  end

  def get_version_number
    latest = DatabaseVersion.where(
      obj_id: id,
      obj_type: self.class.name
    ).order(version_number: :desc).pluck(:version_number).first
    latest || 0
  end

end


