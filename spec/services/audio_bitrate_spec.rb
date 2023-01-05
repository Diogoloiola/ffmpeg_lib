require_relative '../../services/audio_bitrate_service'
# require_relative '../../custom_exceptions/audio_bitrate_expection'

RSpec.describe Services::AudioBitrateService, type: :service do
  describe '#execute' do
    context 'valid values' do
      it 'Visualize full comand' do
        service = Services::AudioBitrateService.new(bitrate: 128)
        expect(service.execute).to eql('-b:a 128k')
      end
    end
  end
end
