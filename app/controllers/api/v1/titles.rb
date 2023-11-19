
module API
    module V1
      class Titles < Grape::API
        include API::V1::Defaults

        resource :titles do
          desc "Return all users"
          get "" do
            ListTitles.call()
          end
        desc "Return a title"
          params do
            requires :id, type: String, desc: "ID of the title"
          end
          get ":id" do
            GetTitle.call(title_id: params[:id])
          end
        end
      end
    end
  end