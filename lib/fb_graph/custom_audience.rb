module FbGraph
  class CustomAudience < Node
    ATTRS = [
      :account_id,
      :approximate_count,
      :name,
      :origin_audience_id,
      :parent_audience_id,
      :parent_category,
      :status,
      :subtype,
      :subtype_name,
      :type,
      :type_name,
      :time_updated
    ]

    attr_accessor *ATTRS

    def initialize(identifier, attributes = {})
      super

      ATTRS.each do |field|
        attributes[field.to_sym] = Time.parse(attributes[field.to_sym]) rescue Time.at(attributes[field.to_sym].to_i) if field == :time_updated
        send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end
