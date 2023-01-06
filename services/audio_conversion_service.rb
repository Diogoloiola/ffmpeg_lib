require_relative '../custom_exceptions/audio_conversion_expection'
require_relative '../custom_exceptions/audio_bitrate_expection'

module Services
  class AudioConversionService
    BITRATE = [64, 128, 256, 320, 1411, 4608, 9216].freeze

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

    def initialize(input_file_name:, output_file_name:, to_format:, bitrate: 128)
      @input_file_name = input_file_name
      @output_file_name = output_file_name
      @to_format = to_format
      @bitrate = bitrate
    end

    def execute
      validate_all!

      "ffmpeg -i #{@input_file_name} -b:a #{@bitrate}k #{@output_file_name}.#{@to_format}"
    end

    private

    def validate_all!
      validate_all_names
      validate_format
      validate_type_bitrate
      validate_bitrate
    end

    def validate_all_names
      return if [@input_file_name, @output_file_name].all? { |file_name| validate_file_name(file_name) }
      return if @input_file_name && CODECS.include?(@input_file_name.split('.').last)

      raise CustomnExepection::AudioConversionExepection, 'Error. Input File Name nil or empty'
    end

    def validate_format
      return if CODECS.include?(@to_format)

      raise CustomnExepection::AudioConversionExepection, 'Error. Codec not supported'
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

    def validate_file_name(file_name)
      return false if file_name.nil?
      return false if file_name.empty?

      true
    end
  end
end
