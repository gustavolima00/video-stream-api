module ListTitles
    class ListTitleResponseSerializer < ActiveModel::Serializer
        has_many :titles, serializer: TitleSerializer
    end
end