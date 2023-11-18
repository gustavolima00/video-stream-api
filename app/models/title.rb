class Title < ApplicationRecord
    has_many :medias, class_name: Media.name

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "image_url", "kind", "name", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["medias"]
    end
end
