require "carrierwave/tinypng/version"

require 'net/https'
require 'uri'
module CarrierWave
  module TinyPNG

    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= CarrierWave::TinyPNG::Configuration.new
    end

    class Configuration
      attr_accessor :key
    end

    def tinypng
      cache_stored_file! if !cached?

      key = CarrierWave::TinyPNG.configuration.key
      input = current_path
      output = current_path

      uri = URI.parse('https://api.tinypng.com/shrink')

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.basic_auth('api', key)

      response = http.request(request, File.binread(input))
      json = JSON.parse(response.body, :symbolize_names => true) || {}
      if response.code == '201'
        File.binwrite(output, http.get(response['location']).body)
      else
        raise CarrierWave::ProcessingError,
              I18n.translate(:'errors.messages.tinypng_processing_error',
                             :error => json[:error],
                             :message => json[:message],
                             :default => I18n.translate(:'errors.messages.tinypng_processing_error',
                                                        :locale => :en))
      end
    end
  end
end
