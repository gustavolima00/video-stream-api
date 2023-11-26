
module API
    module V1
      class Titles < Grape::API
        include API::V1::Defaults

        resource :titles do
          desc "Return all users"
          get "" do
            TitleService.list
          end
        desc "Return a title"
          params do
            requires :id, type: String, desc: "ID of the title"
          end
          get ":id" do
            TitleService.get(id: params[:id])
          end
        end
      end
    end
  end