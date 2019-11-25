# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV["AWS_ACCESS_KEY"],        # required
      aws_secret_access_key: ENV["AWS_SECRET_KEY"],  
      region: ENV['S3_REGION']      # required
    }
    config.fog_directory  = ENV["AWS_BUCKET"]   
    config.storage = :fog
               # required
end