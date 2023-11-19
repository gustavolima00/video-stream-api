class TitleSerializer < ActiveModel::Serializer
    attributes :id, :description, :image_url, :kind
end