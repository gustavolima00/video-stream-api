ActiveAdmin.register Media do
  permit_params :name, :description, :image_url, 
                video_streams_attributes: [:id, :name, :language, :url, :_destroy], 
                subtitle_streams_attributes: [:id, :name, :language, :url, :_destroy]

  index do
      column :name
      column :description
      column :image_url
      column :title
      column 'Video streams' do |media|
        media.video_streams.map do |video_stream|
          "#{video_stream.name || "Unknow"}"
        end
      end
      column 'Subtitle streams' do |media|
        media.subtitle_streams.map do |subtitle_stream|
          "#{subtitle_stream.name || "Unknow"}"
        end
      end
      actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :image_url
    end

    panel "Video Streams" do
      table_for media.video_streams do
        column :name
        column :language
        column :url
      end
    end

    panel "Subtitle Streams" do
      table_for media.subtitle_streams do
        column :name
        column :language
        column :url
      end
    end
  end

  form do |f|
      f.inputs 'Media Details' do
          f.input :name
          f.input :description
          f.input :image_url
          f.input :title_id, as: :select, collection: Title.all.map {|title| [title.name, title.id]}
      end

      f.inputs 'Video streams' do
        f.has_many :video_streams, allow_destroy: true, new_record: true do |video_stream|
          video_stream.input :name
          video_stream.input :language
          video_stream.input :url
        end
      end

      f.inputs 'Subtitle streams' do
        f.has_many :subtitle_streams, allow_destroy: true, new_record: true do |subtitle_stream|
          subtitle_stream.input :name
          subtitle_stream.input :language
          subtitle_stream.input :url
        end
      end

      f.actions
  end
end
