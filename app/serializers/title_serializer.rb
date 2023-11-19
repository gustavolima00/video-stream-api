class TitleSerializer < ActiveModel::Serializer
    attributes :id, :description, :image_url, :kind

    has_many :medias, serializer: MediaSerializer
 end