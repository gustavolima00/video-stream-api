module API
    module V1
      class Base < Grape::API
        mount API::V1::Titles
        mount API::V1::PublicFiles
      end
    end
  end
  