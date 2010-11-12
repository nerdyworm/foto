require 'carrierwave/orm/mongoid'  

CarrierWave.configure do |config|  
 config.storage              = :s3  
 config.s3_access_key_id     = ENV['S3_KEY'] 
 config.s3_secret_access_key = ENV['S3_SECRET']  
  config.s3_bucket           = 'notebookdrawings_dev'
end  


if Rails.env.test?  
 CarrierWave.configure do |config|  
   config.storage = :file  
   config.enable_processing = false  
 end  
end 