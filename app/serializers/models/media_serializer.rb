class MediaSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :image_url
    belongs_to :title, serializer: TitleSerializer

    has_many :video_streams, serializer: VideoStreamSerializer
    has_many :subtitle_streams, serializer: SubtitleStreamSerializer
 end