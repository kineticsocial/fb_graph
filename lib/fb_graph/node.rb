require 'tempfile'

module FbGraph
  class Node
    include Comparison

    attr_accessor :identifier, :endpoint, :access_token, :raw_attributes

    def initialize(identifier, attributes = {})
      @identifier         = identifier
      @endpoint           = File.join(ROOT_URL, identifier.to_s)
      @access_token       = attributes[:access_token]
      @raw_attributes     = attributes
      @cached_collections = {}
    end

    def fetch(options = {})
      options[:access_token] ||= self.access_token if self.access_token
      _fetched_ = get options
      _fetched_[:access_token] ||= options[:access_token]
      self.class.new(_fetched_[:id], _fetched_)
    end

    def self.fetch(identifier, options = {})
      new(identifier).fetch(options)
    end

    def connection(connection, options = {})
      Connection.new(
        self,
        connection,
        options.merge(
          :collection => collection_for(connection, options)
        )
      )
    end

    def update(options = {})
      post options
    end

    def destroy(options = {})
      delete options
    end

    protected

    def get(params = {})
      handle_response do
        _http_client_ = http_client
        response = _http_client_.get build_endpoint(params), build_params(params)
        _http_client_.reset_all
        response
      end
    end

    def post(params = {})
      handle_response do
        _http_client_ = http_client
        response = _http_client_.post build_endpoint(params), build_params(params)
        _http_client_.reset_all
        response
      end
    end

    def delete(params = {})
      _endpoint_, _params_ = build_endpoint(params), build_params(params)
      _endpoint_ = [_endpoint_, _params_.try(:to_query)].compact.join('?')
      handle_response do
        _http_client_ = http_client
        response = _http_client_.delete _endpoint_
        _http_client_.reset_all
        response
      end
    end

    def http_client
      FbGraph.http_client
    end

    private

    def collection_for(connection, options = {})
      collection = if @cached_collections.has_key?(connection) && options.blank?
        @cached_collections[connection]
      else
        get options.merge(:connection => connection)
      end
      Collection.new collection
    end

    def cache_collections(attributes, *connections)
      if (attributes.keys - [:access_token]).present?
        connections.each do |connection|
          @cached_collections[connection] = attributes[connection]
        end
      end
    end
    alias_method :cache_collection, :cache_collections

    def build_endpoint(params = {})
      File.join([self.endpoint, params.delete(:connection), params.delete(:connection_scope)].compact.collect(&:to_s))
    end

    def build_params(params)
      _params_ = params.dup
      _params_[:access_token] ||= self.access_token
      _params_.delete_if do |k, v|
        v.blank? &&
        # NOTE: allow "key=false" in params (ex. for test user creation, it supports "installed=false")
        v != false
      end
      _params_.each do |key, value|
        next if value.blank?
        _params_[key] = case value
        when String, Symbol, Numeric, Date, Time, Rack::OAuth2::AccessToken::Legacy
          value.to_s
        when IO, Tempfile
          value
        when defined?(ActionDispatch::Http::UploadedFile) && ActionDispatch::Http::UploadedFile
          # NOTE: for Rails 3.0.6+
          # ref) http://blog.livedoor.jp/idea_and_players/archives/5184702.html
          value.tempfile
        else
          value.to_json
        end
      end
      _params_.blank? ? nil : _params_
    end

    def handle_response
      response = yield
      case response.body
      when 'true'
        true
      when 'false'
        # NOTE: When the object is not found, Graph API returns
        #  - error response (JSON) when the identifier contains alphabet (ex. graph.facebook.com/iamnotfound)
        #  - false when the identifier is only integer + underbar (ex. graph.facebook.com/1234567890, graph.facebook.com/12345_67890)
        # This is an undocumented behaviour, so facebook might chaange it without any announcement.
        # I've posted this issue on their forum, so hopefully I'll get a document about Graph API error responses.
        # ref) http://forum.developers.facebook.com/viewtopic.php?pid=228256#p228256
        raise NotFound.new('Graph API returned false, so probably it means your requested object is not found.')
      when 'null'
        nil
      when  /^"\d+"$/
        # Offsite Pixels return "1234567890" as the format of the response.
        # Need to parse out the id, and send it back in a hash
        _response_ = Struct.new(:identifier).new
        _response_.identifier = response.body.gsub(/^"|"$/, '').to_i
        _response_
      else
        _response_ = if response.body =~ /^"/
          # NOTE:
          #  Only for comment.reply!, which returns an identifier as String.
          #  Once the API spec changed (I guess FB will do so), we can call "with_indifferent_access" for all response.
          # NOTE:
          #  When MultiJson.engine is JsonGem, parsing JSON String fails.
          #  You should handle this case without MultiJson.
          response.body.gsub('"', '')
        else
          MultiJson.load(response.body).with_indifferent_access
        end

        if (200...300).include?(response.status)
          _response_
        else
          _details = _response_
          _details[:access_token] = self.access_token if _details.kind_of?(Hash) && self.respond_to?(:access_token)
          Exception.handle_structured_response(response.status, _details, response.headers)
        end
      end
    rescue MultiJson::DecodeError
      raise Exception.new(response.status, "Unparsable Response: #{response.body}")
    end
  end
end
