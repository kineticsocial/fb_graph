module FbGraph
  class BusinessManager < Node
    include Connections::AdAccounts
    include Connections::Pages
    include Connections::UserPermissions

    ATTRS = [
      :id,
      :name,
      :timezone_id,
      :primary_page,
      :vertical_id,
      :update_time,
      :updated_by,
      :creation_time,
      :created_by
    ]

    attr_accessor *ATTRS

    def initialize(identifier, attributes = {})
      super

      ATTRS.each do |field|
        send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end
