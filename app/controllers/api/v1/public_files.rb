
module API
    module V1
      class PublicFiles < Grape::API
        include API::V1::Defaults

        resource :public_file do
          desc "Return a file by the path"
          # get path by query param

          params do
            requires :path, type: String, desc: "Path of the file"
          end

          get "", produces: ['application/octet-stream'] do
            content_type "application/octet-stream"
            env['api.format'] = :binary

            file_path = BlobStorageClient.get_file(file_path: params[:path])
            file_name = File.basename(file_path)
            header['Content-Disposition'] = "attachment; filename=#{file_name}"

            File.open(file_path).read
          ensure 
            File.delete(file_path) if file_path.present? && File.exist?(file_path)
          end
        end
      end
    end
  end