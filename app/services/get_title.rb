module GetTitle
    class GetTitleResponse
        attr_reader :title, :medias
        def initialize(title:)
            @title = title
            @medias = title.medias
        end
    end
    
    def self.call(title_id:)
        title = Title.find(title_id)
        GetTitleResponse.new(title: title)
    end
end
