require 'net/http'
require 'uri'
require 'json'

class VideoConverterClient
  def self.send_video(file_path, file_name)
    uri = URI("#{VideoConverterClient.base_url}/raw-videos/send-video")
    uri.query = URI.encode_www_form(fileName: file_name, userUuid: VideoConverterClient.webhook_user_uuid)

    file = File.open(file_path)

    request = Net::HTTP::Post.new(uri)
    form_data = [['file', file]]
    request.set_form form_data, 'multipart/form-data'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    file.close

    response.is_a?(Net::HTTPSuccess)
  end

  private 

  def self.base_url
    ENV['VIDEO_CONVERTER_BASE_URL'] || 'http://localhost:5001'
  end

  def self.webhook_user_uuid
    ENV['VIDEO_CONVERTER_WEBHOOK_USER_UUID'] || '968565e6-61f6-45c6-ab68-963eb2c04428'
  end
end