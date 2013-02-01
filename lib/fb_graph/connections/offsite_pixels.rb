module FbGraph
  module Connections
    module OffsitePixels
      def offsite_pixels(options = {})
        offsite_pixels = self.connection :offsitepixels, options
        offsite_pixels.map! do |offsite_pixel|
          OffsitePixel.new offsite_pixel[:id], offsite_pixel.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end

      def offsite_pixel!(options = {}) 
        post(options.merge(:connection => :offsitepixels)) # only id is returned
      end
    end
  end
end
