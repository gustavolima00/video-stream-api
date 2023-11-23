## Register webhook user

require_relative '../../app/services/video_converter_client'
begin
    Rails.logger.info "Registering webhook user"
    VideoConverterClient.register_webhook_user
rescue => e
    Rails.logger.error "Error registering webhook user: #{e}"
end