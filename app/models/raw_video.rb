class RawVideo < ApplicationRecord
    belongs_to :media

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "external_uuid", "id", "id_value", "media_id", "name", "process_subtitles_status", "process_video_status", "raw_video_path", "updated_at", "uuid"]
    end
end
  