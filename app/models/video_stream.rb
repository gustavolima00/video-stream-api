class VideoStream < ApplicationRecord
  belongs_to :media

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "language", "media_id", "name", "updated_at", "url"]
  end
end
