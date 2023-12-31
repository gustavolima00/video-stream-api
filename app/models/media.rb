class Media < ApplicationRecord
  table_name = "media"
  belongs_to :title
  has_many :video_streams
  has_many :subtitle_streams

  accepts_nested_attributes_for :video_streams, allow_destroy: true
  accepts_nested_attributes_for :subtitle_streams, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description image_url title_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["subtitle_streams", "title", "video_streams"]
  end
end
