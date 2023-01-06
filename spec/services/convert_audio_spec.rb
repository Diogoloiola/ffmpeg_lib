require_relative '../../services/audio_conversion_service'
require_relative '../../custom_exceptions/audio_conversion_expection'
require_relative '../../custom_exceptions/audio_bitrate_expection'

RSpec.describe Services::AudioConversionService, type: :service do
  describe '#execute' do
    context 'with valid values' do
      it 'correct result' do
        service = Services::AudioConversionService.new(input_file_name: 'input.mp3', output_file_name: 'output',
                                                       to_format: 'mp3')
        expect(service.execute).to eql('ffmpeg -i input.mp3 -b:a 128k output.mp3')
      end
    end

    context 'with wrong params' do
      it 'with input_file_name nil' do
        service = Services::AudioConversionService.new(input_file_name: nil, output_file_name: nil,
                                                       to_format: 'mp3')
        expect { service.execute }.to raise_error(CustomnExepection::AudioConversionExepection)
      end

      it 'with input_file_name empty' do
        service = Services::AudioConversionService.new(input_file_name: '', output_file_name: '', to_format: 'mp3')
        expect { service.execute }.to raise_error(CustomnExepection::AudioConversionExepection)
      end

      it 'with output_file_name nil' do
        service = Services::AudioConversionService.new(input_file_name: '', output_file_name: nil, to_format: 'mp3')
        expect { service.execute }.to raise_error(CustomnExepection::AudioConversionExepection)
      end

      it 'with output_file_name empty' do
        service = Services::AudioConversionService.new(input_file_name: '', output_file_name: '', to_format: 'mp3')
        expect { service.execute }.to raise_error(CustomnExepection::AudioConversionExepection)
      end

      it 'with codec not suported' do
        service = Services::AudioConversionService.new(input_file_name: 'input.mp3', output_file_name: 'output',
                                                       to_format: 'mp4')
        expect { service.execute }.to raise_error(CustomnExepection::AudioConversionExepection)
      end

      it 'Invalid type in constructor' do
        service = Services::AudioConversionService.new(input_file_name: 'input.mp3', output_file_name: 'output',
                                                       to_format: 'mp3', bitrate: 10)

        expect { service.execute }.to raise_error(CustomnExepection::AudioBitrateExepection)
      end

      it 'Invalida bitrage range' do
        service = Services::AudioConversionService.new(input_file_name: 'input.mp3', output_file_name: 'output',
                                                       to_format: 'mp3', bitrate: 3000)

        expect { service.execute }.to raise_error(CustomnExepection::AudioBitrateExepection)
      end
    end
  end
end
