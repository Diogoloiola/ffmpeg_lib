require_relative '../custom_exceptions/audio_conversion_expection'

module Services
  class AudioConversionService
    CODECS = %w[
      ogg
      mp1
      mp2
      mp3
      wav
      mp3adu
      hcom
      iac
      dvaudio
    ].freeze

    def initialize(file_name:, to:)
      @file_name = file_name
      @to = to
    end

    def execute
      validate_all!

      "#{@file_name}.#{@to}"
    end

    private

    def validate_all!
      validate_file_name
      validate_format
    end

    def validate_file_name
      return unless @file_name.nil? || @file_name.empty?

      raise CustomnExepection::AudioConversionExepection, 'Error. File name nil or empty'
    end

    def validate_format
      return if CODECS.include?(@to)

      raise CustomnExepection::AudioConversionExepection, 'Error. Codec not supported'
    end
  end
end
