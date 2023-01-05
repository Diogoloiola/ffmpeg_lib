module Services
  class AudioBitrateService
    def initialize(bitrate:)
      @bitrate = bitrate
    end

    def execute
      "-b:a #{@bitrate}k"
    end
  end
end
