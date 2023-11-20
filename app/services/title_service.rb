class TitleService
    class ListTitleResponse
        attr_reader :titles
        def initialize(titles)
            @titles = titles
        end
    end

    class GetTitleResponse
        attr_reader :title, :medias
        def initialize(title:)
            @title = title
            @medias = title.medias
        end
    end

    def self.get(id:)
        title = Title.find(id)
        GetTitleResponse.new(title: title)
    end
    
    def self.list
        titles = Title.all
        ListTitleResponse.new(titles)
    end
end

