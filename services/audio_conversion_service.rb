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

    def initialize(input_file_name:, output_file_name:, to_format:, codec: 128)
      @input_file_name = input_file_name
      @output_file_name = output_file_name
      @to_format = to_format
      @codec = codec
    end

    def execute
      validate_all!

      "#{@output_file_name}.#{@to_format}"
    end

    private

    def validate_all!
      validate_output_file_name
      validate_format
    end

    def validate_output_file_name
      return unless @output_file_name.nil? || @output_file_name.empty?

      raise CustomnExepection::AudioConversionExepection, 'Error. File name nil or empty'
    end

    def validate_format
      return if CODECS.include?(@to_format)

      raise CustomnExepection::AudioConversionExepection, 'Error. Codec not supported'
    end
  end
end
