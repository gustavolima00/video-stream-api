require 'net/http'
require 'uri'
require 'json'

class VideoConverterClient
  def self.send_video(file:, file_name: nil)
    original_filename = file.original_filename
    file_extension = File.extname(original_filename)
    file_name ||= File.basename(SecureRandom.hex, file_extension)
    uri = URI("#{VideoConverterClient.base_url}/raw-videos/send-video")
    uri.query = URI.encode_www_form(fileName: file_name, userUuid: VideoConverterClient.webhook_user_uuid)
    request = Net::HTTP::Put.new(uri)
    form_data = [['file', file]]
    request.set_form form_data, 'multipart/form-data'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise "Error sending video to video converter - #{response.body} - #{response.code}"
    end

    JSON.parse(response.body)
  end

  def self.get_video(uuid:)
    uri = URI("#{VideoConverterClient.base_url}/raw-videos/#{uuid}")
    request = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise "Error getting video with uuid #{uuid} - #{response.body} - #{response.code}"
    end

    JSON.parse(response.body)
  end

  def self.list_videos
    uri = URI("#{VideoConverterClient.base_url}/raw-videos")
    uri.query = URI.encode_www_form(userUuid: VideoConverterClient.webhook_user_uuid)

    request = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise "Error listing videos - #{response.body} - #{response.code}"
    end

    JSON.parse(response.body)
  end

  def self.register_webhook_user
    uri = URI("#{VideoConverterClient.base_url}/webhook-user/#{VideoConverterClient.webhook_user_uuid}")
    uri.query = URI.encode_www_form(webhookUrl: VideoConverterClient.webhook_url, events: VideoConverterClient.webhook_events)

    request = Net::HTTP::Put.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise "Error registering webhook user - #{response.body} - #{response.code}"
    end

    JSON.parse(response.body)
  end

  private 

  def self.webhook_events
    %w[
      VideoTracksExtracted
      SubtitleTracksExtracted
      VideoTrackExtractionFailed
      SubtitleTrackExtractionFailed
    ]
  end

  def self.webhook_url
    ENV['VIDEO_CONVERTER_WEBHOOK_URL'] || 'http://localhost:3000/api/v1/video_converter_webhook'
  end

  def self.base_url
    ENV['VIDEO_CONVERTER_BASE_URL'] || 'http://localhost:5275'
  end

  def self.webhook_user_uuid
    ENV['VIDEO_CONVERTER_WEBHOOK_USER_UUID'] || '968565e6-61f6-45c6-ab68-963eb2c04428'
  end
end