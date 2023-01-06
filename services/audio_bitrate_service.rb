require_relative '../custom_exceptions/audio_bitrate_expection'
module Services
  class AudioBitrateService
    BITRATE = [64, 128, 256, 320, 1411, 4608, 9216].freeze

    def initialize(bitrate:)
      @bitrate = bitrate
    end

    def execute
      validate_all!

      "-b:a #{@bitrate}k"
    end

    private

    def validate_all!
      validate_type_bitrate
      validate_bitrate
    end

    def validate_type_bitrate
      return if @bitrate.is_a? Integer

      raise CustomnExepection::AudioBitrateExepection,
            "Error. Type must be Integer, provider in initialize #{@bitrate.class}"
    end

    def validate_bitrate
      return if BITRATE.include?(@bitrate)

      raise CustomnExepection::AudioBitrateExepection,
            "Error. Invalid bitrate, only bitrate permited #{BITRATE.map(&:to_s).join(', ')}"
    end
  end
end
