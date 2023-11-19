module GetTitle
    class GetTitleResponseSerializer < ActiveModel::Serializer
        has_one :media, serializer: MediaSerializer
        has_one :title, serializer: TitleSerializer
    end
end