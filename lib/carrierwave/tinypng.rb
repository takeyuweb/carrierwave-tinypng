require "carrierwave/tinypng/version"

require 'net/https'
require 'uri'
require "tinify"

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

      input = current_path
      output = current_path

      Tinify.key = CarrierWave::TinyPNG.configuration.key
      Tinify.validate!

      begin
        source = Tinify.from_file(input)
        source.to_file(output)
      rescue => e
        Rails.logger.error(
          I18n.translate(
            :'errors.messages.tinypng_processing_error',
            error: e.class.to_s,
            message: e.message.to_s,
            default: I18n.translate(:'errors.messages.tinypng_processing_error', locale: :en)
          )
        )

        return input
      end
    end
  end
end

if defined?(Rails)
  module CarrierWave
    module TinyPNG
      class Railtie < Rails::Railtie
        initializer 'carrierwave_tinypng.setup_paths' do |app|
          available_locales = app.config.i18n.available_locales.present? ?
              [app.config.i18n.available_locales].flatten : []
          available_locales_pattern = available_locales.empty? ?
              '*' : "{#{ available_locales.join(',') }}"
          files = Dir[File.join(File.dirname(__FILE__),
                                'locale',
                                "#{available_locales_pattern}.yml")]
          I18n.load_path = files.concat(I18n.load_path)
        end
      end
    end
  end
end
