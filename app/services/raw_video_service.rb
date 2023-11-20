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
            raw_video_path: response["path"],
            media_id: media_id
        )
    end

    def self.update(id:, file:, media_id:)
        raw_file = RawVideo.find(id)
        response = VideoConverterClient.send_video(file: file, file_name: raw_file.name)
        Rails.logger.info "Response from video converter: #{response}"
        raw_file.update!(
            process_subtitles_status: response["extractSubtitleStatus"],
            process_video_status: response["extractTracksStatus"],
            external_uuid: response["uuid"],
            name: response["name"],
            raw_video_path: response["path"],
            media_id: media_id
        )
    end

    def self.process_webhook(content)
        Rails.logger.info "Processing webhook: #{content}"
        event = content["Event"]
        payload = content["Payload"]

        case event
        when "VideoTracksExtracted"
            process_video_tracks_extracted(payload)
        when "SubtitleTracksExtracted"
            process_subtitle_tracks_extracted(payload)
        when "VideoTrackExtractionFailed"
            process_video_track_extraction_failed(payload)
        when "SubtitleTrackExtractionFailed"
            process_subtitle_track_extraction_failed(payload)
        else
            Rails.logger.warn "Unknown event: #{event}"
        end
    end

    def self.process_video_tracks_extracted(payload)
        external_uuid = payload["RawVideoUuid"]
        video_tracks = payload["VideoTracks"]
        raw_video = RawVideo.find_by!(external_uuid: external_uuid)
        media_id = raw_video.media_id

        Media.transaction do
            video_tracks.each do |video_track|
                VideoStream.create!(
                    language: video_track["Language"],
                    path: video_track["Path"],
                    media_id: media_id
                )
            end

            raw_video.update!(process_video_status: "Finished")
        end
    end

    def self.process_subtitle_tracks_extracted(payload)
        external_uuid = payload["RawVideoUuid"]
        subtitle_tracks = payload["Subtitles"]
        raw_video = RawVideo.find_by!(external_uuid: external_uuid)
        media_id = raw_video.media_id

        Media.transaction do
            subtitle_tracks.each do |subtitle_track|
                Subtitle.create!(
                    language: subtitle_track["Language"],
                    path: subtitle_track["Path"],
                    media_id: media_id
                )
            end

            raw_video.update!(process_subtitles_status: "Finished")
        end
    end

    def self.process_video_track_extraction_failed(payload)
        external_uuid = payload["RawVideoUuid"]
        raw_video = RawVideo.find_by!(external_uuid: external_uuid)
        raw_video.update!(process_video_status: "Failed")
    end

    def self.process_subtitle_track_extraction_failed(payload)
        external_uuid = payload["RawVideoUuid"]
        raw_video = RawVideo.find_by!(external_uuid: external_uuid)
        raw_video.update!(process_subtitles_status: "Failed")
    end
end

