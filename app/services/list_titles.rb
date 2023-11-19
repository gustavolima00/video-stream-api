class ListTitles
    class ListTitleResponse
        attr_reader :titles
        def initialize(titles)
            @titles = titles
        end
    end
    def self.call()
        titles = Title.all
        ListTitleResponse.new(titles)
    end
end

