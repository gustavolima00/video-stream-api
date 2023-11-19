class Title < ApplicationRecord
    has_many :medias, class_name: Media.name
    accepts_nested_attributes_for :medias, allow_destroy: true

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "image_url", "kind", "name", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["medias"]
    end
end
