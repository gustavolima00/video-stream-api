require 'net/http'
require 'uri'

class BlobStorageService
    def self.get_file(file_path)
        base_url = ENV['BLOB_STORAGE_URL']
        uri = URI("#{base_url}/get-file")
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
end