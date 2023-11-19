ActiveAdmin.register Title do
  permit_params :name, :description, :kind,
                media_attributes: [:id, :name, :description, :image_url, :title_id, :_destroy,
                                   video_streams_attributes: [:id, :url, :language, :name, :media_id, :_destroy],
                                   subtitle_streams_attributes: [:id, :url, :language, :name, :media_id, :_destroy]]

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :description
      f.input :kind

      f.has_many :medias, allow_destroy: true, new_record: true do |m|
        m.input :name
        m.input :description
        m.input :image_url

        m.has_many :video_streams, allow_destroy: true, new_record: true do |vs|
          vs.input :url
          vs.input :language
          vs.input :name
        end

        m.has_many :subtitle_streams, allow_destroy: true, new_record: true do |ss|
          ss.input :url
          ss.input :language
          ss.input :name
        end
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :kind
    end

    panel "Media" do
      table_for resource.medias do
        column :name
        column :description
        column :image_url
      end
    end

    resource.medias.each do |media|
      panel "Video Streams for #{media.name}" do
        table_for media.video_streams do
          column :url
          column :language
          column :name
        end
      end

      panel "Subtitle Streams for #{media.name}" do
        table_for media.subtitle_streams do
          column :url
          column :language
          column :name
        end
      end
    end
  end
end
