module FbGraph
  class Connection < Collection
    attr_accessor :collection, :connection, :owner, :options
    delegate :total_count, :unread_count, :updated_time, :to => :collection

    def initialize(owner, connection, options = {})
      @owner = owner
      @options = options
      @connection = connection
      @collection = options.delete(:collection) || Collection.new
      replace collection
    end

    def next(_options_ = {})
      if self.collection.next.present? || (self.collection.cursors.present? && self.collection.cursors[:after].present?)
        connection_method = if self.owner.respond_to?(self.connection)
          self.connection
        else
          self.owner.public_methods.detect do |method|
            method.to_s.gsub('_', '') == self.connection.to_s
          end
        end
        
        _next_options_ = self.options.merge(
          ((self.collection.next.present?) ? self.collection.next : {:after => self.collection.cursors[:after]}).merge(_options_)
        )
        
        self.owner.send(
          connection_method,
          _next_options_
        )
      else
        self.class.new(self.owner, self.connection)
      end
    end

    def previous(_options_ = {})
      if self.collection.previous.present? || (self.collection.cursors.present? && self.collection.cursors[:before].present?)
        _previous_options_ = self.options.merge(_options_).merge(
          (self.collection.previous.present?) ? self.collection.previous : {:before => self.collection.cursors[:before]}
        )
        self.owner.send(self.connection, _previous_options_)
      else
        self.class.new(self.owner, self.connection)
      end
    end
  end
end