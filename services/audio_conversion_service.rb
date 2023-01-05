require_relative '../custom_exceptions/audio_conversion_expection'

module Services
  class AudioConversionService
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
    end

    def validate_file_name
      return unless @file_name.nil? || @file_name.empty?

      raise CustomnExepection::AudioConversionExepection, 'Error. File name nil or empty'
    end
  end
end
