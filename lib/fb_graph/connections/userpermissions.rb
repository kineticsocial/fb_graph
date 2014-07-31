module FbGraph
  module Connections
    module UserPermissions
      def userpermissions(options = {})
        self.connection(:userpermissions, options).first
      end

      def userpermissions!(options = {})
        post options.merge(:connection => :userpermissions)
      end
    end
  end
end