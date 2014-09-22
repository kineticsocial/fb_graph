module FbGraph
  class PartnerCategory < Node
    ATTRS = [
      :name,
      :description,
      :details,
      :source,
      :parent_category,
      :approximate_count,
      :status,
      :targeting_type,
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
