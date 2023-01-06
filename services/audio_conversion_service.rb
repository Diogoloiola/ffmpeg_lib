require_relative '../custom_exceptions/audio_conversion_expection'
require_relative '../custom_exceptions/audio_bitrate_expection'
require_relative '../constants/audio'
module Services
  class AudioConversionService
    def initialize(input_file_name:, output_file_name:, to_format:, bitrate: 128)
      @input_file_name = input_file_name
      @output_file_name = output_file_name
      @to_format = to_format
      @bitrate = bitrate
    end

    def create_command
      validate_all!

      "ffmpeg -i #{@input_file_name} -b:a #{@bitrate}k #{@output_file_name}.#{@to_format}"
    end

    def execute
      system(create_command)
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
