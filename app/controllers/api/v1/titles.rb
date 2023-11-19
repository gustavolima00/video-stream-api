module API
    module V1
      class Titles < Grape::API
        include API::V1::Defaults
        resource :titles do
          desc "Return all users"
          get "" do
            Title.preload(medias: [:video_streams, :subtitle_streams]).all
          end
        desc "Return a title"
          params do
            requires :id, type: String, desc: "ID of the title"
          end
          get ":id" do
            Title.where(id: permitted_params[:id]).first!
          end
        end
      end
    end
  end