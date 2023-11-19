class SubtitleStreamSerializer < ActiveModel::Serializer
    attributes :id, :name, :language, :url
    belongs_to :media, serializer: MediaSerializer
 end