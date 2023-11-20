ActiveAdmin.register RawVideo do

  permit_params :raw_video_path, :process_subtitles_status, :process_video_status, :external_uuid, :name, :media_id, :file

  form do |f|
    f.inputs do
      f.input :media
      f.input :name
      f.file_field :file
      # outros campos conforme necessário
    end
    f.actions
  end

  controller do
    def create
      # Lógica para manipular o upload e fazer a chamada da API
      uploaded_file = params[:raw_video][:file]
      puts uploaded_file.inspect
    end
  end
  
end
