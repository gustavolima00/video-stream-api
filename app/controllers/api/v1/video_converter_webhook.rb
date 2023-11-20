
module API
    module V1
      class VideoConverterWebhook < Grape::API
        include API::V1::Defaults

        resource :video_converter_webhook do
          desc "Receive webhook from video converter"
          # receives a json on post

          post "" do
            # call service to process webhook
            RawVideoService.process_webhook(params)

            status 200
            body { }
          end
        end
      end
    end
  end