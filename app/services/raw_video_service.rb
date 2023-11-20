class RawVideoService
    def self.create(file:, media_id:)
        response = VideoConverterClient.send_video(file: file)
        Rails.logger.info "Response from video converter: #{response}"
        RawVideo.create!(
            uuid: SecureRandom.uuid,
            process_subtitles_status: response["extractSubtitleStatus"],
            process_video_status: response["extractTracksStatus"],
            external_uuid: response["uuid"],
            name: response["name"],
            media_id: media_id
        )
    end
end

