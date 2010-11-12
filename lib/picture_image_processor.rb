class PictureImageProcessor < CarrierWave::Uploader::Base  
  include CarrierWave::RMagick  
  include CarrierWave::Compatibility::Paperclip
  
  version :thumb do  
    process :resize_to_fill => [ 100, 100 ]  
  end
  
  version :medium do
    process :resize_to_fill => [ 350, 220 ]  
  end  

  version :large do
    process :resize_to_fill => [ 730, 730 ]  
  end
  
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def extension_white_list  
    %w(jpg jpeg gif png)  
  end 
  
  def paperclip_path
    "things/:id/:attachment/:style.:extension"
  end
end