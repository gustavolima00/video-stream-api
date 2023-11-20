require 'net/http'
require 'uri'

class BlobStorageClient
    def self.get_file(file_path:)
        uri = URI("#{BlobStorageClient.base_url}/get-file")
        uri.query = URI.encode_www_form(file_path: file_path)
        file_extension = File.extname(file_path)
        file = Tempfile.new([SecureRandom.hex, file_extension])
        file.binmode

        Net::HTTP.get_response(uri) do |res|
            res.read_body do |segment|
                file.write(segment)
            end
        end
        file.close

        file.path
    end

    private

    def self.base_url
        ENV['BLOB_STORAGE_URL'] || 'http://localhost:5000'
    end
end